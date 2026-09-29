# Variables globales para la configuración de la VPC y VPN
# Estas variables se usan en los módulos de VPC y VPN y se definen en terraform.tfvars por ambiente

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
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
  description = "Nombre de la VPC"
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