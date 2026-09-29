environment               = "qa"
aws_region               = "us-east-1"

# Configuración de la VPC
vpc_cidr                 = "10.1.0.0/16"
enable_dns_hostnames     = true
enable_dns_support       = true

# Subredes públicas - dos AZs para alta disponibilidad en QA
public_subnet_cidrs      = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnet_names      = ["qa-public-subnet-az1", "qa-public-subnet-az2"]

# Subredes privadas - dos AZs para alta disponibilidad en QA
private_subnet_cidrs     = ["10.1.10.0/24", "10.1.20.0/24"]
private_subnet_names     = ["qa-private-subnet-az1", "qa-private-subnet-az2"]

# Zonas de disponibilidad para QA
availability_zones       = ["us-east-1a", "us-east-1b"]

# Configuración de NAT Gateway - NAT dedicada por AZ en QA para mejor aislamiento
single_nat_gateway       = false
one_nat_gateway_per_az   = true

# Configuración de VPN
enable_vpn               = true
vpn_cidr                 = "10.1.100.0/24"
vpn_instance_type        = "t3.small"

# Etiquetado para optimización de costos en QA
tags = {
  Environment     = "qa"
  Project         = "cloud-ops-vpc"
  CostCenter      = "qa-team"
  ManagedBy       = "terraform"
  ComplianceLevel = "qa-standard"
  BackupRequired  = "true"
  Monitoring      = "standard"
  DataClassification = "internal"
  SLATarget       = "99.9"
}

# Nombres de recursos con sufijo de ambiente
resource_prefix         = "qa"
vpc_name                = "qa-main-vpc"
igw_name                = "qa-internet-gateway"
ngw_name                = "qa-nat-gateway"
eip_ngw_name            = "qa-nat-eip"
rtb_public_name         = "qa-public-rt"
rtb_private_name        = "qa-private-rt"
acm_certificate_arn     = ""
vpn_customer_gateway_ip = "203.0.113.20"
vpn_bgp_asn             = 65002