# Módulo de VPC: crea la infraestructura de red base con segmentación
# de subredes públicas y privadas, conectividad a internet y NAT.

# VPC principal con CIDR block configurable
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpc-${var.environment}"
      Description = "VPC principal para ${var.project_name} ambiente ${var.environment}"
      Environment = var.environment
    }
  )
}

# Internet Gateway para conectividad pública
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-igw-${var.environment}"
      Description = "Internet Gateway para acceso a internet"
    }
  )
}

# Subredes públicas - una por cada AZ配置
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-public-subnet-${count.index + 1}-${var.environment}"
      Description = "Subred pública en AZ ${var.availability_zones[count.index]}"
      Type        = "public"
      Environment = var.environment
    }
  )
}

# Subredes privadas - una por cada AZ
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, length(var.availability_zones) + count.index)
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-subnet-${count.index + 1}-${var.environment}"
      Description = "Subred privada en AZ ${var.availability_zones[count.index]}"
      Type        = "private"
      Environment = var.environment
    }
  )
}

# Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? length(var.availability_zones) : 0

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-eip-nat-${count.index + 1}-${var.environment}"
      Description = "EIP para NAT Gateway ${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateways - uno por AZ para alta disponibilidad
resource "aws_nat_gateway" "main" {
  count = var.enable_nat_gateway ? length(var.availability_zones) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-nat-gw-${count.index + 1}-${var.environment}"
      Description = "NAT Gateway para subred privada en AZ ${var.availability_zones[count.index]}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# Tabla de enrutamiento para subredes públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-public-rt-${var.environment}"
      Description = "Tabla de enrutamiento pública"
      Type        = "public"
      Environment = var.environment
    }
  )
}

# Asociación de subredes públicas con tabla de rutas pública
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Tabla de enrutamiento para subredes privadas
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-rt-${var.environment}"
      Description = "Tabla de enrutamiento privada"
      Type        = "private"
      Environment = var.environment
    }
  )
}

# Crear tablas de enrutamiento privadas adicionales por NAT Gateway
resource "aws_route_table" "private_with_nat" {
  count = var.enable_nat_gateway && length(var.availability_zones) > 1 ? length(var.availability_zones) - 1 : 0

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index + 1].id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-rt-nat-${count.index + 2}-${var.environment}"
      Description = "Tabla de enrutamiento privada con NAT ${count.index + 2}"
      Type        = "private"
      Environment = var.environment
    }
  )
}

# Asociación de subredes privadas con tabla de rutas privada principal
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  # Asignar la primera subred privada a la tabla principal
  # Las demás subredes privadas se asignan a sus tablas correspondientes
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = count.index == 0 ? aws_route_table.private.id : aws_route_table.private_with_nat[count.index - 1].id
}