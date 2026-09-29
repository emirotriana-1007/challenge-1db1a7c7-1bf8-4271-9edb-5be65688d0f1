# =====================================================
# Outputs de la VPC
# =====================================================
# Expone los identificadores y configuraciones principales
# de la VPC para su uso en otros módulos o para referencia
# externa del proyecto.

output "vpc_id" {
  description = "Identificador de la VPC principal"
  value       = aws_vpc.principal.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = aws_vpc.principal.cidr_block
}

output "vpc_dns_hostnames_enabled" {
  description = "Indica si los nombres de host DNS están habilitados"
  value       = aws_vpc.principal.enable_dns_hostnames
}

output "vpc_dns_support_enabled" {
  description = "Indica si el soporte DNS está habilitado"
  value       = aws_vpc.principal.enable_dns_support
}

# =====================================================
# Outputs del Internet Gateway
# =====================================================

output "internet_gateway_id" {
  description = "Identificador del Internet Gateway"
  value       = aws_internet_gateway.principal.id
}

# =====================================================
# Outputs de Subredes Públicas
# =====================================================

output "subnet_publica_1_id" {
  description = "Identificador de la subred pública en AZ ${var.region}a"
  value       = aws_subnet.publica_1.id
}

output "subnet_publica_1_cidr" {
  description = "Bloque CIDR de la subred pública en AZ ${var.region}a"
  value       = aws_subnet.publica_1.cidr_block
}

output "subnet_publica_2_id" {
  description = "Identificador de la subred pública en AZ ${var.region}b"
  value       = aws_subnet.publica_2.id
}

output "subnet_publica_2_cidr" {
  description = "Bloque CIDR de la subred pública en AZ ${var.region}b"
  value       = aws_subnet.publica_2.cidr_block
}

output "subnet_publica_3_id" {
  description = "Identificador de la subred pública en AZ ${var.region}c"
  value       = aws_subnet.publica_3.id
}

output "subnet_publica_3_cidr" {
  description = "Bloque CIDR de la subred pública en AZ ${var.region}c"
  value       = aws_subnet.publica_3.cidr_block
}

# =====================================================
# Outputs de Subredes Privadas
# =====================================================

output "subnet_privada_1_id" {
  description = "Identificador de la subred privada en AZ ${var.region}a"
  value       = aws_subnet.privada_1.id
}

output "subnet_privada_1_cidr" {
  description = "Bloque CIDR de la subred privada en AZ ${var.region}a"
  value       = aws_subnet.privada_1.cidr_block
}

output "subnet_privada_2_id" {
  description = "Identificador de la subred privada en AZ ${var.region}b"
  value       = aws_subnet.privada_2.id
}

output "subnet_privada_2_cidr" {
  description = "Bloque CIDR de la subred privada en AZ ${var.region}b"
  value       = aws_subnet.privada_2.cidr_block
}

output "subnet_privada_3_id" {
  description = "Identificador de la subred privada en AZ ${var.region}c"
  value       = aws_subnet.privada_3.id
}

output "subnet_privada_3_cidr" {
  description = "Bloque CIDR de la subred privada en AZ ${var.region}c"
  value       = aws_subnet.privada_3.cidr_block
}

# =====================================================
# Outputs de NAT Gateways
# =====================================================

output "nat_gateway_1_id" {
  description = "Identificador del NAT Gateway en AZ ${var.region}a"
  value       = aws_nat_gateway.principal_1.id
}

output "nat_gateway_1_ip" {
  description = "Dirección IP elástica del NAT Gateway en AZ ${var.region}a"
  value       = aws_nat_gateway.principal_1.allocation_id
}

output "nat_gateway_2_id" {
  description = "Identificador del NAT Gateway en AZ ${var.region}b"
  value       = aws_nat_gateway.principal_2.id
}

output "nat_gateway_2_ip" {
  description = "Dirección IP elástica del NAT Gateway en AZ ${var.region}b"
  value       = aws_nat_gateway.principal_2.allocation_id
}

output "nat_gateway_3_id" {
  description = "Identificador del NAT Gateway en AZ ${var.region}c"
  value       = aws_nat_gateway.principal_3.id
}

output "nat_gateway_3_ip" {
  description = "Dirección IP elástica del NAT Gateway en AZ ${var.region}c"
  value       = aws_nat_gateway.principal_3.allocation_id
}

# =====================================================
# Outputs de Tablas de Enrutamiento
# =====================================================

output "route_table_publica_id" {
  description = "Identificador de la tabla de enrutamiento pública"
  value       = aws_route_table.publica.id
}

output "route_table_privada_1_id" {
  description = "Identificador de la tabla de enrutamiento privada para AZ ${var.region}a"
  value       = aws_route_table.privada_1.id
}

output "route_table_privada_2_id" {
  description = "Identificador de la tabla de enrutamiento privada para AZ ${var.region}b"
  value       = aws_route_table.privada_2.id
}

output "route_table_privada_3_id" {
  description = "Identificador de la tabla de enrutamiento privada para AZ ${var.region}c"
  value       = aws_route_table.privada_3.id
}

output "route_table_vpn_id" {
  description = "Identificador de la tabla de enrutamiento para VPN"
  value       = aws_route_table.vpn.id
}

# =====================================================
# Outputs de VPN
# =====================================================

output "vpn_gateway_id" {
  description = "Identificador del VPN Gateway"
  value       = aws_vpn_gateway.principal.id
}

output "vpn_connection_id" {
  description = "Identificador de la conexión VPN"
  value       = aws_vpn_connection.principal.id
}

output "vpn_customer_gateway_id" {
  description = "Identificador del Customer Gateway"
  value       = aws_customer_gateway.principal.id
}

output "vpn_tunnel_1_status" {
  description = "Estado del túnel VPN 1"
  value       = aws_vpn_connection.principal.tunnel_1_status
}

output "vpn_tunnel_2_status" {
  description = "Estado del túnel VPN 2"
  value       = aws_vpn_connection.principal.tunnel_2_status
}

output "vpn_remote_network_cidr" {
  description = "Bloque CIDR de la red remota del cliente para VPN"
  value       = var.vpn_remote_network_cidr
}