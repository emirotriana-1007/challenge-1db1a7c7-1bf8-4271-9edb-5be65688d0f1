# =====================================================
# Configuración del Backend Remoto
# =====================================================
# Este archivo configura el almacenamiento remoto del estado
# de Terraform en S3 y el bloqueo de estado con DynamoDB.
# Esto permite el trabajo colaborativo y evita conflictos
# cuando múltiples personas ejecutan Terraform simultáneamente.
#
# El bucket de S3 debe existir previamente en la cuenta de AWS.
# La tabla de DynamoDB debe existir previamente con la clave
# "LockID" de tipo String.

terraform {
  backend "s3" {
    bucket         = var.backend_bucket
    key            = "${var.environment}/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.backend_dynamodb_table

    # Bloqueo de estado para evitar ejecuciones concurrentes
    # que podrían corromper el estado de Terraform
    locking = true
  }
}

# =====================================================
# Proveedor AWS
# =====================================================
# Se declara el proveedor de AWS con la región configurada.
# El proveedor es necesario para todos los recursos de AWS.
# Se usa la versión ~> 5.0 para mantener compatibilidad
# con las características actuales de Terraform.

provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.tags_defaults,
      {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = "Terraform"
      }
    )
  }

  # Configuración de retry para operaciones que pueden fallar
  # temporalmente debido a limitaciones de la API de AWS
  retries {
    max_attempts = 3
  }
}

# =====================================================
# Datos del Backend Remoto
# =====================================================
# Se obtienen los datos del bucket S3 y la tabla DynamoDB
# para validar que existen antes de inicializar Terraform.
# Esta validación es opcional pero recomendada para detectar
# problemas de configuración tempranamente.

data "aws_s3_bucket" "terraform_state" {
  bucket = var.backend_bucket
}

data "aws_dynamodb_table" "terraform_locks" {
  name = var.backend_dynamodb_table
}

# =====================================================
# Outputs del Backend
# =====================================================
# Información sobre el backend configurado para referencia
# y validación de la configuración.

output "backend_bucket" {
  description = "Nombre del bucket S3 para el estado remoto"
  value       = var.backend_bucket
  sensitive   = false
}

output "backend_dynamodb_table" {
  description = "Nombre de la tabla DynamoDB para bloqueos"
  value       = var.backend_dynamodb_table
  sensitive   = false
}

output "backend_region" {
  description = "Región del backend S3"
  value       = var.region
  sensitive   = false
}

output "backend_key" {
  description = "Clave del estado en S3"
  value       = "${var.environment}/terraform.tfstate"
  sensitive   = false
}