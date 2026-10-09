# =====================================================
# Configuración de la VPC principal
# =====================================================
# Este módulo crea la VPC con el CIDR block principal
# y configura las opciones de DNS y tráfico de instancias.

resource "aws_vpc" "principal" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-vpc"
      Environment = var.environment
      Project     = var.project_name
    }
  )
}

# =====================================================
# Gateway de Internet
# =====================================================
# Proporciona conectividad a Internet para las subredes
# públicas a través de una NAT Gateway en cada AZ.

resource "aws_internet_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-igw"
      Environment = var.environment
    }
  )
}

# =====================================================
# Subredes Públicas
# =====================================================
# Las subredes públicas permiten el tráfico directo a Internet
# a través del Internet Gateway. Se crean una por zona de
# disponibilidad para garantizar alta disponibilidad.

resource "aws_subnet" "publica_1" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-publica-1"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

resource "aws_subnet" "publica_2" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-publica-2"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

resource "aws_subnet" "publica_3" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.public_subnet_cidrs[2]
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-publica-3"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

# =====================================================
# Subredes Privadas
# =====================================================
# Las subredes privadas no tienen acceso directo a Internet.
# El tráfico sale a través de las NAT Gateways ubicadas en
# las subredes públicas. Ideal para bases de datos y aplicaciones.

resource "aws_subnet" "privada_1" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = "${var.aws_region}a"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-privada-1"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_subnet" "privada_2" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = "${var.aws_region}b"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-privada-2"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_subnet" "privada_3" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.private_subnet_cidrs[2]
  availability_zone = "${var.aws_region}c"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-privada-3"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

# =====================================================
# Elastic IPs para NAT Gateways
# =====================================================
# Se necesita una EIP por cada NAT Gateway para permitir
# que el tráfico saliente desde las subredes privadas
# tenga una IP pública fija y conocida.

resource "aws_eip" "nat_gateway_1" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-eip-nat-1"
      Environment = var.environment
    }
  )
}

resource "aws_eip" "nat_gateway_2" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-eip-nat-2"
      Environment = var.environment
    }
  )
}

resource "aws_eip" "nat_gateway_3" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-eip-nat-3"
      Environment = var.environment
    }
  )
}

# =====================================================
# NAT Gateways
# =====================================================
# Las NAT Gateways permiten a las subredes privadas
# conectarse a Internet para actualizaciones y descargas,
# pero bloquean conexiones entrantes desde Internet.

resource "aws_nat_gateway" "principal_1" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = aws_subnet.publica_1.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-nat-1"
      Environment = var.environment
    }
  )

  depends_on = [aws_internet_gateway.principal]
}

resource "aws_nat_gateway" "principal_2" {
  allocation_id = aws_eip.nat_gateway_2.id
  subnet_id     = aws_subnet.publica_2.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-nat-2"
      Environment = var.environment
    }
  )

  depends_on = [aws_internet_gateway.principal]
}

resource "aws_nat_gateway" "principal_3" {
  allocation_id = aws_eip.nat_gateway_3.id
  subnet_id     = aws_subnet.publica_3.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-nat-3"
      Environment = var.environment
    }
  )

  depends_on = [aws_internet_gateway.principal]
}

# =====================================================
# Tablas de Enrutamiento
# =====================================================
# La tabla de enrutamiento pública dirige el tráfico
# hacia el Internet Gateway. Las tablas de enrutamiento
# privadas dirigen el tráfico hacia las NAT Gateways.

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-rt-publica"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

resource "aws_route_table" "privada_1" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.principal_1.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-rt-privada-1"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_route_table" "privada_2" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.principal_2.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-rt-privada-2"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_route_table" "privada_3" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.principal_3.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-rt-privada-3"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

# =====================================================
# Asociación de Subredes con Tablas de Enrutamiento
# =====================================================
# Asocia cada subred pública a la tabla de enrutamiento
# pública y cada subred privada a su tabla correspondiente.

resource "aws_route_table_association" "publica_1" {
  subnet_id      = aws_subnet.publica_1.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "publica_2" {
  subnet_id      = aws_subnet.publica_2.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "publica_3" {
  subnet_id      = aws_subnet.publica_3.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "privada_1" {
  subnet_id      = aws_subnet.privada_1.id
  route_table_id = aws_route_table.privada_1.id
}

resource "aws_route_table_association" "privada_2" {
  subnet_id      = aws_subnet.privada_2.id
  route_table_id = aws_route_table.privada_2.id
}

resource "aws_route_table_association" "privada_3" {
  subnet_id      = aws_subnet.privada_3.id
  route_table_id = aws_route_table.privada_3.id
}

# =====================================================
# Customer Gateway para VPN
# =====================================================
# Representa el dispositivo o servicio de VPN del cliente
# en las instalaciones (on-premises) que se conectará a
# la VPN de AWS.

resource "aws_customer_gateway" "principal" {
  bgp_asn    = var.vpn_bgp_asn
  ip_address = var.vpn_customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-cgw"
      Environment = var.environment
    }
  )
}

# =====================================================
# VPN Gateway (Virtual Private Gateway)
# =====================================================
# El VPN Gateway se adjunta a la VPC y permite la
# conexión VPN entre la VPC y la red del cliente.

resource "aws_vpn_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-vpg"
      Environment = var.environment
    }
  )
}

# =====================================================
# Adjuntar VPN Gateway a la VPC
# =====================================================

resource "aws_vpn_gateway_attachment" "vpc_attachment" {
  vpc_id         = aws_vpc.principal.id
  vpn_gateway_id = aws_vpn_gateway.principal.id
}

# =====================================================
# Conexión VPN
# =====================================================
# La conexión VPN establece el túnel IPSec entre
# AWS y el gateway del cliente.

resource "aws_vpn_connection" "principal" {
  customer_gateway_id = aws_customer_gateway.principal.id
  vpn_gateway_id      = aws_vpn_gateway.principal.id
  type                = "ipsec.1"
  static_routes_only  = var.vpn_static_routes_only

  tunnel_inside_ip_version = "ipv4"

  tunnel1_preshared_key = var.vpn_preshared_key_1
  tunnel1_inside_cidr   = var.vpn_tunnel_cidr_1

  tunnel2_preshared_key = var.vpn_preshared_key_2
  tunnel2_inside_cidr   = var.vpn_tunnel_cidr_2

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-vpn"
      Environment = var.environment
    }
  )
}

# =====================================================
# Tabla de Enrutamiento para VPN
# =====================================================
# Permite el tráfico desde la VPN hacia las subredes
# privadas de la VPC.

resource "aws_route_table" "vpn" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = var.vpn_remote_network_cidr
    gateway_id = aws_vpn_gateway.principal.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-rt-vpn"
      Environment = var.environment
      Type        = "vpn"
    }
  )
}

# =====================================================
# Asociación de subredes privadas con tabla VPN
# =====================================================
# Las subredes privadas deben poder recibir tráfico
# desde la VPN para permitir la comunicación con los
# recursos internos de la VPC.

resource "aws_route_table_association" "vpn_privada_1" {
  subnet_id      = aws_subnet.privada_1.id
  route_table_id = aws_route_table.vpn.id
}

resource "aws_route_table_association" "vpn_privada_2" {
  subnet_id      = aws_subnet.privada_2.id
  route_table_id = aws_route_table.vpn.id
}

resource "aws_route_table_association" "vpn_privada_3" {
  subnet_id      = aws_subnet.privada_3.id
  route_table_id = aws_route_table.vpn.id
}