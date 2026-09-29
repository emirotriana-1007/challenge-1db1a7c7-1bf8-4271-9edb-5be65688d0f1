# Variables específicas para el módulo VPC
# Estas variables permiten configurar la VPC, subredes y componentes asociados

variable "vpc_cidr_block" {
  description = "CIDR block para la VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes privadas"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para las subredes privadas"
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

variable "tags" {
  description = "Etiquetas para los recursos de la VPC"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para distribuir las subredes"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "create_igw" {
  description = "Crear Internet Gateway para la VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente al lanzar instancias en subredes públicas"
  type        = bool
  default     = true
}