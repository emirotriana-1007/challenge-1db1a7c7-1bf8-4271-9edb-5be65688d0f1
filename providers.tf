# Configuración de providers para Terraform
# Define el proveedor de AWS y la versión de Terraform requerida

terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    # Este bloque se completará en backend.tf
    # Se usa S3 para almacenar el estado de Terraform y DynamoDB para bloqueo
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.tags
  }
}

# Configuración adicional para optimizar la creación de recursos
# y manejar dependencias entre ellos
provider "aws" {
  alias  = "east"
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

# Validación de la configuración del provider
# Asegura que la región especificada es válida
locals {
  valid_regions = [
    "us-east-1", "us-east-2", "us-west-1", "us-west-2",
    "ap-south-1", "ap-northeast-1", "ap-northeast-2",
    "ap-southeast-1", "ap-southeast-2", "ca-central-1",
    "eu-central-1", "eu-west-1", "eu-west-2", "eu-west-3",
    "eu-north-1", "sa-east-1"
  ]
  region_validation = contains(local.valid_regions, var.aws_region) ? "Valid" : "Invalid AWS region"
}

output "region_validation" {
  value = local.region_validation
}