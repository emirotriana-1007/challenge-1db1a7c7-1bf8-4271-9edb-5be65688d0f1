# Variables específicas para el módulo VPN
# Estas variables permiten configurar la VPN para conectividad remota

variable "vpc_id" {
  description = "ID de la VPC donde se configurará la VPN"
  type        = string
}

variable "vpn_client_cidr_block" {
  description = "CIDR block para los clientes VPN"
  type        = string
}

variable "vpn_name" {
  description = "Nombre del recurso VPN"
  type        = string
}

variable "vpn_server_common_name" {
  description = "Common Name (CN) para el certificado del servidor VPN"
  type        = string
  default     = "vpn.example.com"
}

variable "vpn_allowed_cidr_blocks" {
  description = "Lista de CIDR blocks permitidos para acceder a la VPN"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Etiquetas para los recursos de la VPN"
  type        = map(string)
  default     = {}
}

variable "vpn_gateway_id" {
  description = "ID del VPN Gateway asociado a la VPC"
  type        = string
}

variable "customer_gateway_id" {
  description = "ID del Customer Gateway"
  type        = string
}

variable "create_vpn_connection" {
  description = "Crear conexión VPN"
  type        = bool
  default     = true
}

variable "vpn_connection_static_routes_only" {
  description = "Usar rutas estáticas para la conexión VPN"
  type        = bool
  default     = true
}

variable "vpn_connection_local_ipv4_network_cidr" {
  description = "CIDR block local para la conexión VPN"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpn_connection_remote_ipv4_network_cidr" {
  description = "CIDR block remoto para la conexión VPN"
  type        = string
  default     = "0.0.0.0/0"
}