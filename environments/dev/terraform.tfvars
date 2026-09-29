environment               = "dev"
aws_region               = "us-east-1"

# Configuración de la VPC
vpc_cidr                 = "10.0.0.0/16"
enable_dns_hostnames     = true
enable_dns_support       = true

# Subredes públicas - dos AZs para alta disponibilidad en desarrollo
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_names      = ["dev-public-subnet-az1", "dev-public-subnet-az2"]

# Subredes privadas - dos AZs para alta disponibilidad en desarrollo
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.20.0/24"]
private_subnet_names     = ["dev-private-subnet-az1", "dev-private-subnet-az2"]

# Zonas de disponibilidad para desarrollo
availability_zones       = ["us-east-1a", "us-east-1b"]

# Configuración de NAT Gateway - una por AZ en producción, compartida en dev
single_nat_gateway       = true
one_nat_gateway_per_az   = false

# Configuración de VPN
enable_vpn               = true
vpn_cidr                 = "10.0.100.0/24"
vpn_instance_type        = "t3.micro"

# Etiquetado para optimización de costos en desarrollo
tags = {
  Environment     = "dev"
  Project         = "cloud-ops-vpc"
  CostCenter      = "dev-team"
  ManagedBy       = "terraform"
  ComplianceLevel = "dev-standard"
  BackupRequired  = "false"
  Monitoring      = "basic"
  DataClassification = "internal"
}

# Nombres de recursos con sufijo de ambiente
resource_prefix         = "dev"
vpc_name                = "dev-main-vpc"
igw_name                = "dev-internet-gateway"
ngw_name                = "dev-nat-gateway"
eip_ngw_name            = "dev-nat-eip"
rtb_public_name         = "dev-public-rt"
rtb_private_name        = "dev-private-rt"
acm_certificate_arn     = ""
vpn_customer_gateway_ip = "203.0.113.10"
vpn_bgp_asn             = 65001