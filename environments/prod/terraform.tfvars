environment               = "prod"
aws_region               = "us-east-1"

# Configuración de la VPC - CIDR más amplio para producción
vpc_cidr                 = "10.2.0.0/16"
enable_dns_hostnames     = true
enable_dns_support       = true

# Subredes públicas - tres AZs para alta disponibilidad en producción (SLA 99.9%)
public_subnet_cidrs      = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
public_subnet_names      = ["prod-public-subnet-az1", "prod-public-subnet-az2", "prod-public-subnet-az3"]

# Subredes privadas - tres AZs para alta disponibilidad en producción
private_subnet_cidrs     = ["10.2.10.0/24", "10.2.20.0/24", "10.2.30.0/24"]
private_subnet_names     = ["prod-private-subnet-az1", "prod-private-subnet-az2", "prod-private-subnet-az3"]

# Zonas de disponibilidad para producción - tres AZs para cumplir SLA 99.9%
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Configuración de NAT Gateway - NAT dedicada por AZ en producción para máxima disponibilidad
single_nat_gateway       = false
one_nat_gateway_per_az   = true

# Configuración de VPN
enable_vpn               = true
vpn_cidr                 = "10.2.100.0/24"
vpn_instance_type        = "t3.medium"

# Etiquetado para optimización de costos en producción
tags = {
  Environment     = "prod"
  Project         = "cloud-ops-vpc"
  CostCenter      = "prod-team"
  ManagedBy       = "terraform"
  ComplianceLevel = "prod-high"
  BackupRequired  = "true"
  Monitoring      = "enhanced"
  DataClassification = "confidential"
  SLATarget       = "99.9"
  RTO             = "4h"
  RPO             = "1h"
  DREnabled       = "true"
}

# Nombres de recursos con sufijo de ambiente
resource_prefix         = "prod"
vpc_name                = "prod-main-vpc"
igw_name                = "prod-internet-gateway"
ngw_name                = "prod-nat-gateway"
eip_ngw_name            = "prod-nat-eip"
rtb_public_name         = "prod-public-rt"
rtb_private_name        = "prod-private-rt"
acm_certificate_arn     = "arn:aws:acm:us-east-1:123456789012:certificate/example-cert-arn"
vpn_customer_gateway_ip = "203.0.113.30"
vpn_bgp_asn             = 65003