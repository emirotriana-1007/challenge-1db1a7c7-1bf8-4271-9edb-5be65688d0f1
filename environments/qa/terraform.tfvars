# =====================================================
# Ambiente QA
# =====================================================
# NOTA DE SEGURIDAD: las vpn_preshared_key_* son valores de EJEMPLO.
# En un proyecto real nunca van en texto plano en el repo; se gestionan
# con AWS Secrets Manager / SSM Parameter Store o variables de entorno.

# --- Identidad y región ---
aws_region   = "us-east-1"
project_name = "cloud-ops-vpc"
environment  = "qa"

# --- VPC (Fase 1) ---
vpc_cidr_block = "10.1.0.0/16"
vpc_name       = "qa-main-vpc"

# --- Subredes: 3 por tier (main.tf usa indices [0], [1], [2]) ---
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]

# --- VPN (Fase 3) ---
vpn_name                = "qa-vpn"
vpn_client_cidr_block   = "192.168.100.0/22"
vpn_bgp_asn             = 65002
vpn_customer_gateway_ip = "203.0.113.20"
vpn_static_routes_only  = true
vpn_remote_network_cidr = "172.16.0.0/16"
vpn_tunnel_cidr_1       = "169.254.20.0/30"
vpn_tunnel_cidr_2       = "169.254.21.0/30"
vpn_preshared_key_1     = "CHANGE_ME_qa_tunnel1" # placeholder, no es una clave real
vpn_preshared_key_2     = "CHANGE_ME_qa_tunnel2" # placeholder, no es una clave real

# --- Backend remoto ---
backend_bucket         = "cloud-ops-vpc-tfstate-qa"
backend_dynamodb_table = "cloud-ops-vpc-tflock-qa"

# --- Etiquetas ---
tags = {
  Environment = "qa"
  Project     = "cloud-ops-vpc"
  ManagedBy   = "terraform"
  CostCenter  = "qa-team"
  SLATarget   = "99.9"
}
