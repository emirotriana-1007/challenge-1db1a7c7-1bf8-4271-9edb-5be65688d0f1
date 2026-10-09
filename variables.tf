# Variables globales para la configuración de la VPC y VPN
# Estas variables se usan en los módulos de VPC y VPN y se definen en terraform.tfvars por ambiente

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto, usado como prefijo en los tags Name."
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "El CIDR block de la VPC debe ser un bloque CIDR válido (ej. 10.0.0.0/16)"
  }
}

variable "vpc_name" {
  description = "vpc_name"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes públicas"
  type        = list(string)
  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "Debe haber al menos dos subredes públicas para alta disponibilidad"
  }
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes privadas"
  type        = list(string)
  validation {
    condition     = length(var.private_subnet_cidrs) >= 2
    error_message = "Debe haber al menos dos subredes privadas para alta disponibilidad"
  }
}

variable "vpn_client_cidr_block" {
  description = "CIDR block para los clientes VPN"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpn_client_cidr_block, 0))
    error_message = "El CIDR block para clientes VPN debe ser un bloque CIDR válido (ej. 192.168.1.0/22)"
  }
}

variable "vpn_name" {
  description = "Nombre del recurso VPN"
  type        = string
}

variable "vpn_bgp_asn" {
  description = "ASN BGP del gateway del cliente (on-premise)."
  type        = number
}

variable "vpn_customer_gateway_ip" {
  description = "IP pública del dispositivo VPN on-premise."
  type        = string
}

variable "vpn_static_routes_only" {
  description = "Usar rutas estáticas (true) en lugar de BGP dinámico (false)."
  type        = bool
}

variable "vpn_preshared_key_1" {
  description = "Clave precompartida del túnel VPN 1."
  type        = string
  sensitive   = true
}

variable "vpn_server_common_name" {
  description = "Common Name (CN) para el certificado del servidor VPN"
  type        = string
  default     = "vpn.example.com"
}

variable "vpn_preshared_key_2" {
  description = "Clave precompartida del túnel VPN 2."
  type        = string
  sensitive   = true
}

variable "vpn_tunnel_cidr_1" {
  description = "Bloque /30 interno del túnel VPN 1 (ej. 169.254.10.0/30)."
  type        = string
}

variable "vpn_tunnel_cidr_2" {
  description = "Bloque /30 interno del túnel VPN 2 (ej. 169.254.11.0/30)."
  type        = string
}

variable "vpn_allowed_cidr_blocks" {
  description = "Lista de CIDR blocks permitidos para acceder a la VPN"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpn_remote_network_cidr" {
  description = "Bloque CIDR de la red remota (on-premise) alcanzable por la VPN."
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "VPC-VPN-Setup"
  }
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para las subredes privadas"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS para la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS para la VPC"
  type        = bool
  default     = true
}

variable "backend_bucket" {
  description = "Nombre del bucket S3 donde se almacena el estado remoto de Terraform."
  type        = string
}

variable "backend_dynamodb_table" {
  description = "Nombre de la tabla DynamoDB usada para el bloqueo de estado."
  type        = string
}




