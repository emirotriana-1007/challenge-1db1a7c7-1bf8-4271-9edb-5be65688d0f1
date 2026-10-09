output "vpn_connection_id" {
  description = "Identificador único de la conexión VPN establecida"
  value       = aws_vpn_connection.main.id
}

output "vpn_connection_state" {
  description = "Estado actual de la conexión VPN"
  value       = aws_vpn_connection.main.state
}

output "customer_gateway_ip_address" {
  description = "Dirección IP pública del gateway del cliente para la conexión VPN"
  value       = var.customer_gateway_ip
}

output "vpn_tunnel_inside_ip_customer" {
  description = "Dirección IP interna del túnel VPN desde el lado del cliente"
  value       = aws_vpn_connection.main.tunnel1_inside_ip
}

output "vpn_tunnel_inside_ip_aws" {
  description = "Dirección IP interna del túnel VPN desde el lado de AWS"
  value       = aws_vpn_connection.main.tunnel1_aws_inside_ip
}

output "vpn_tunnel_2_inside_ip_customer" {
  description = "Dirección IP interna del segundo túnel VPN desde el lado del cliente"
  value       = aws_vpn_connection.main.tunnel2_inside_ip
}

output "vpn_tunnel_2_inside_ip_aws" {
  description = "Dirección IP interna del segundo túnel VPN desde el lado de AWS"
  value       = aws_vpn_connection.main.tunnel2_aws_inside_ip
}

output "vpn_preshared_key_tunnel_1" {
  description = "Clave pre-compartida para el túnel 1 de la conexión VPN"
  value       = aws_vpn_connection.main.tunnel1_preshared_key
  sensitive   = true
}

output "vpn_preshared_key_tunnel_2" {
  description = "Clave pre-compartida para el túnel 2 de la conexión VPN"
  value       = aws_vpn_connection.main.tunnel2_preshared_key
  sensitive   = true
}

output "vpn_remote_route" {
  description = "Ruta remota configurada para la conexión VPN"
  value       = aws_vpn_connection.main.remote_gateway_ip
}

output "vpn_static_routes" {
  description = "Rutas estáticas configuradas en la conexión VPN"
  value       = aws_vpn_connection.main.static_routes_only
}

output "customer_gateway_id" {
  description = "Identificador del gateway del cliente creado en AWS"
  value       = aws_customer_gateway.main.id
}

output "vpn_gateway_id" {
  description = "Identificador del VPN gateway adjunto a la VPC"
  value       = aws_vpn_gateway.main.id
}

output "vpn_gateway_arn" {
  description = "ARN del VPN gateway para referencias en otras partes de la infraestructura"
  value       = aws_vpn_gateway.main.arn
}

output "tunnel_status" {
  description = "Estado de ambos túneles de la conexión VPN"
  value = {
    tunnel1 = aws_vpn_connection.main.tunnel1_status
    tunnel2 = aws_vpn_connection.main.tunnel2_status
  }
}

output "vpn_category" {
  description = "Categoría del servicio VPN proporcionado por AWS"
  value       = aws_vpn_connection.main.category
}

output "dns_server_ip" {
  description = "Servidores DNS configurados para la resolución de nombres a través de la VPN"
  value       = var.dns_server
}

output "vpn_enabled" {
  description = "Indicador booleano que confirma si la VPN está habilitada"
  value       = var.enable_vpn
}