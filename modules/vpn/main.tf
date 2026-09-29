# Módulo de VPN: configura la conectividad remota segura a la VPC
# mediante AWS Site-to-Site VPN, incluyendo Customer Gateway y conexión.

# Customer Gateway - representa el dispositivo de VPN del cliente
resource "aws_customer_gateway" "main" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-cgw-${var.environment}"
      Description = "Customer Gateway para VPN remota"
      Environment = var.environment
    }
  )
}

# VPN Connection - establece el túnel VPN entre AWS y el Customer Gateway
resource "aws_vpn_connection" "main" {
  customer_gateway_id = aws_customer_gateway.main.id
  type                = "ipsec.1"
  static_routes_only  = var.static_routes_only

  # Opciones de túnel
  tunnel1_preshared_key = var.tunnel1_preshared_key != "" ? var.tunnel1_preshared_key : random_string.tunnel1_key.result
  tunnel2_preshared_key = var.tunnel2_preshared_key != "" ? var.tunnel2_preshared_key : random_string.tunnel2_key.result

  tunnel1_inside_cidr = var.tunnel_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr != "" ? var.tunnel2_inside_cidr : cidrsubnet(var.tunnel_inside_cidr, 8, 1)

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpn-${var.environment}"
      Description = "VPN Connection para conectividad remota"
      Environment = var.environment
    }
  )
}

# Transit Gateway - necesario para conectar múltiples VPCs o para VPN de alta disponibilidad
resource "aws_ec2_transit_gateway" "main" {
  count = var.enable_transit_gateway ? 1 : 0

  amazon_asn             = var.transit_gateway_asn
  description            = "Transit Gateway para ${var.project_name} - ${var.environment}"
  dns_support            = "enable"
  vpn_ecmp_support       = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-${var.environment}"
      Description = "Transit Gateway para conectividad de VPN"
      Environment = var.environment
    }
  )
}

# Asociación del Transit Gateway con la VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_id = aws_ec2_transit_gateway.main[0].id
  vpc_id             = var.vpc_id
  subnet_ids         = var.transit_gateway_subnet_ids

  dns_support   = "enable"
  ipv6_support  = "disable"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-attachment-${var.environment}"
      Description = "Attachment de Transit Gateway a VPC"
      Environment = var.environment
    }
  )
}

# Attach de la VPN al Transit Gateway
resource "aws_ec2_transit_gateway_vpn_attachment" "main" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_id     = aws_ec2_transit_gateway.main[0].id
  vpn_connection_id      = aws_vpn_connection.main.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-vpn-attachment-${var.environment}"
      Description = "Attachment de VPN a Transit Gateway"
      Environment = var.environment
    }
  )
}

# Tabla de rutas de Transit Gateway para VPN
resource "aws_ec2_transit_gateway_route_table" "vpn" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_id = aws_ec2_transit_gateway.main[0].id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-rt-vpn-${var.environment}"
      Description = "Tabla de rutas del Transit Gateway para VPN"
      Environment = var.environment
    }
  )
}

# Ruta en Transit Gateway para el tráfico de la VPN
resource "aws_ec2_transit_gateway_route" "vpn_route" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpn[0].id
  destination_cidr_block         = var.vpn_destination_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpn_attachment.main[0].id
}

# Keys aleatorias para los túneles si no se proporcionan
resource "random_string" "tunnel1_key" {
  count   = var.tunnel1_preshared_key == "" ? 1 : 0
  length  = 16
  special = false
}

resource "random_string" "tunnel2_key" {
  count   = var.tunnel2_preshared_key == "" ? 1 : 0
  length  = 16
  special = false
}

# Route Table de la VPC para dirigir tráfico a través de la VPN
resource "aws_route" "vpn_route" {
  count = length(var.vpn_route_table_ids) > 0 ? 1 : 0

  route_table_id         = var.vpn_route_table_ids[0]
  destination_cidr_block = var.vpn_destination_cidr
  transit_gateway_id     = var.enable_transit_gateway ? aws_ec2_transit_gateway.main[0].id : null

  # Fallback a vpn_connection si no se usa transit gateway
  vpn_gateway_id = var.enable_transit_gateway ? null : aws_vpn_connection.main.id
}

# Security Group para la VPN endpoint
resource "aws_security_group" "vpn" {
  name        = "${var.project_name}-vpn-sg-${var.environment}"
  description = "Security Group para tráfico VPN"
  vpc_id      = var.vpc_id

  # Permitir tráfico IPSec (UDP 500, 4500)
  ingress {
    description = " IPSec IKE"
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = [var.customer_gateway_ip]
  }

  ingress {
    description = "IPSec NAT-T"
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = [var.customer_gateway_ip]
  }

  # Permitir tráfico GRE si se usa tunneling dinámico
  ingress {
    description = "GRE tunneling"
    from_port   = 0
    to_port     = 0
    protocol    = "gre"
    cidr_blocks = [var.customer_gateway_ip]
  }

  # Permitir todo el tráfico de salida
  egress {
    description = "Todo el tráfico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpn-sg-${var.environment}"
      Description = "Security Group para endpoints de VPN"
      Environment = var.environment
    }
  )
}