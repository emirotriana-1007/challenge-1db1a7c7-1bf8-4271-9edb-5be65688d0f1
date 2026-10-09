# =====================================================
# Ambiente PROD
# =====================================================
# NOTA DE SEGURIDAD: las vpn_preshared_key_* son valores de EJEMPLO.
# En un proyecto real nunca van en texto plano en el repo; se gestionan
# con AWS Secrets Manager / SSM Parameter Store o variables de entorno.

# --- Identidad y región ---
aws_region   = "us-east-1"
project_name = "cloud-ops-vpc"
environment  = "prod"

# --- VPC (Fase 1) - CIDR mas amplio para produccion ---
vpc_cidr_block = "10.2.0.0/16"
vpc_name       = "prod-main-vpc"

# --- Subredes: 3 por tier, 3 AZs para SLA 99.9% ---
public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_subnet_cidrs = ["10.2.10.0/24", "10.2.20.0/24", "10.2.30.0/24"]

# --- VPN (Fase 3) ---
vpn_name                = "prod-vpn"
vpn_client_cidr_block   = "192.168.100.0/22"
vpn_bgp_asn             = 65003
vpn_customer_gateway_ip = "203.0.113.30"
vpn_static_routes_only  = true
vpn_remote_network_cidr = "172.16.0.0/16"
vpn_tunnel_cidr_1       = "169.254.30.0/30"
vpn_tunnel_cidr_2       = "169.254.31.0/30"
vpn_preshared_key_1     = "CHANGE_ME_prod_tunnel1" # placeholder, no es una clave real
vpn_preshared_key_2     = "CHANGE_ME_prod_tunnel2" # placeholder, no es una clave real

# --- Backend remoto ---
backend_bucket         = "cloud-ops-vpc-tfstate-prod"
backend_dynamodb_table = "cloud-ops-vpc-tflock-prod"

# --- Etiquetas ---
tags = {
  Environment = "prod"
  Project     = "cloud-ops-vpc"
  ManagedBy   = "terraform"
  CostCenter  = "prod-team"
  SLATarget   = "99.9"
}
