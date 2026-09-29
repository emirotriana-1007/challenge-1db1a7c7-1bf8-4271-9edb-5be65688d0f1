# Outputs del módulo VPC - exponen los IDs y ARNs necesarios
# para que otros módulos y el main.tf consuman estos valores.

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_default_security_group_id" {
  description = "ID del security group por defecto de la VPC"
  value       = aws_vpc.main.default_security_group_id
}

output "vpc_default_network_acl_id" {
  description = "ID del Network ACL por defecto de la VPC"
  value       = aws_vpc.main.default_network_acl_id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "Lista de CIDR blocks de subredes públicas"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  description = "Lista de CIDR blocks de subredes privadas"
  value       = aws_subnet.private[*].cidr_block
}

output "nat_gateway_ids" {
  description = "Lista de IDs de los NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_ips" {
  description = "Lista de IPs públicas de los NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada principal"
  value       = aws_route_table.private.id
}

output "availability_zones" {
  description = "Lista de AZs utilizadas"
  value       = var.availability_zones
}