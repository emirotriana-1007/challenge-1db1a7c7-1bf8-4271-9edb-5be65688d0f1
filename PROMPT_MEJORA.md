# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Analista, Tecnología Cloud Networking, Junior

### Brecha de conocimiento
Configura redes básicas en la nube, incluyendo VPC, segmentos de red, conectividad a internet y reglas de enrutamiento en escenarios sencillos. Comprende las mejores prácticas para subneteo y la segmentación de redes. Conoce los principios básicos de VPC Peering, VPC Flow Logs y VPC Endpoints. Tiene conocimiento introductorio de VPN, incluyendo su configuración básica para interconectar redes y asegurar la conectividad remota

### Misión / candidato
Candidato Junior en Cloud Ops con experiencia inicial en infraestructura en la nube

### Reto
- Tema: Configuración de Redes Básicas y Conectividad
- Seniority: junior-l1
- Tipo: practical
- Título: Configuración de una VPC en AWS
- Tiempo estimado: 4 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Creación de la VPC — objetivo: Configurar una VPC con subredes públicas y privadas. — entregable (NO resolver): VPC configurada con subredes públicas y privadas.
- Fase 2: Configuración de Reglas de Enrutamiento — objetivo: Establecer reglas de enrutamiento para la conectividad a internet y la comunicación entre subredes. — entregable (NO resolver): Tablas de enrutamiento configuradas para las subredes públicas y privadas.
- Fase 3: Configuración de VPN — objetivo: Configurar una VPN para asegurar la conectividad remota. — entregable (NO resolver): VPN configurada para asegurar la conectividad remota a la VPC.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: variables.tf ===
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

// === ARCHIVO: providers.tf ===
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

// === ARCHIVO: modules/vpc/variables.tf ===
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

// === ARCHIVO: modules/vpn/variables.tf ===
# Variables específicas para el módulo VPN
# Estas variables permiten configurar la VPN para conectividad remota

variable "vpc_id" {
  description = "ID de la VPC donde se configurará la VPN"
  type        = string
}

variable "vpn_client_cidr_block" {
  description = "CIDR block para los clientes VPN"
  type        = string
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
  description = "Etiquetas para los recursos de la VPN"
  type        = map(string)
  default     = {}
}

variable "vpn_gateway_id" {
  description = "ID del VPN Gateway asociado a la VPC"
  type        = string
}

variable "customer_gateway_id" {
  description = "ID del Customer Gateway"
  type        = string
}

variable "create_vpn_connection" {
  description = "Crear conexión VPN"
  type        = bool
  default     = true
}

variable "vpn_connection_static_routes_only" {
  description = "Usar rutas estáticas para la conexión VPN"
  type        = bool
  default     = true
}

variable "vpn_connection_local_ipv4_network_cidr" {
  description = "CIDR block local para la conexión VPN"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpn_connection_remote_ipv4_network_cidr" {
  description = "CIDR block remoto para la conexión VPN"
  type        = string
  default     = "0.0.0.0/0"
}

// === ARCHIVO: main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# =====================================================
# Configuración de la VPC principal
# =====================================================
# Este módulo crea la VPC con el CIDR block principal
# y configura las opciones de DNS y tráfico de instancias.

resource "aws_vpc" "principal" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-vpc"
      Environment = var.environment
      Project     = var.project_name
    }
  )
}

# =====================================================
# Gateway de Internet
# =====================================================
# Proporciona conectividad a Internet para las subredes
# públicas a través de una NAT Gateway en cada AZ.

resource "aws_internet_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-igw"
      Environment = var.environment
    }
  )
}

# =====================================================
# Subredes Públicas
# =====================================================
# Las subredes públicas permiten el tráfico directo a Internet
# a través del Internet Gateway. Se crean una por zona de
# disponibilidad para garantizar alta disponibilidad.

resource "aws_subnet" "publica_1" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.subnet_public_cidr_1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-publica-1"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

resource "aws_subnet" "publica_2" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.subnet_public_cidr_2
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-publica-2"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

resource "aws_subnet" "publica_3" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.subnet_public_cidr_3
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-publica-3"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

# =====================================================
# Subredes Privadas
# =====================================================
# Las subredes privadas no tienen acceso directo a Internet.
# El tráfico sale a través de las NAT Gateways ubicadas en
# las subredes públicas. Ideal para bases de datos y aplicaciones.

resource "aws_subnet" "privada_1" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.subnet_private_cidr_1
  availability_zone = "${var.region}a"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-privada-1"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_subnet" "privada_2" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.subnet_private_cidr_2
  availability_zone = "${var.region}b"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-privada-2"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_subnet" "privada_3" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.subnet_private_cidr_3
  availability_zone = "${var.region}c"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-privada-3"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

# =====================================================
# Elastic IPs para NAT Gateways
# =====================================================
# Se necesita una EIP por cada NAT Gateway para permitir
# que el tráfico saliente desde las subredes privadas
# tenga una IP pública fija y conocida.

resource "aws_eip" "nat_gateway_1" {
  domain = "vpc"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-eip-nat-1"
      Environment = var.environment
    }
  )
}

resource "aws_eip" "nat_gateway_2" {
  domain = "vpc"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-eip-nat-2"
      Environment = var.environment
    }
  )
}

resource "aws_eip" "nat_gateway_3" {
  domain = "vpc"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-eip-nat-3"
      Environment = var.environment
    }
  )
}

# =====================================================
# NAT Gateways
# =====================================================
# Las NAT Gateways permiten a las subredes privadas
# conectarse a Internet para actualizaciones y descargas,
# pero bloquean conexiones entrantes desde Internet.

resource "aws_nat_gateway" "principal_1" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = aws_subnet.publica_1.id

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-nat-1"
      Environment = var.environment
    }
  )

  depends_on = [aws_internet_gateway.principal]
}

resource "aws_nat_gateway" "principal_2" {
  allocation_id = aws_eip.nat_gateway_2.id
  subnet_id     = aws_subnet.publica_2.id

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-nat-2"
      Environment = var.environment
    }
  )

  depends_on = [aws_internet_gateway.principal]
}

resource "aws_nat_gateway" "principal_3" {
  allocation_id = aws_eip.nat_gateway_3.id
  subnet_id     = aws_subnet.publica_3.id

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-nat-3"
      Environment = var.environment
    }
  )

  depends_on = [aws_internet_gateway.principal]
}

# =====================================================
# Tablas de Enrutamiento
# =====================================================
# La tabla de enrutamiento pública dirige el tráfico
# hacia el Internet Gateway. Las tablas de enrutamiento
# privadas dirigen el tráfico hacia las NAT Gateways.

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal.id
  }

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-rt-publica"
      Environment = var.environment
      Type        = "publica"
    }
  )
}

resource "aws_route_table" "privada_1" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.principal_1.id
  }

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-rt-privada-1"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_route_table" "privada_2" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.principal_2.id
  }

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-rt-privada-2"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

resource "aws_route_table" "privada_3" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.principal_3.id
  }

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-rt-privada-3"
      Environment = var.environment
      Type        = "privada"
    }
  )
}

# =====================================================
# Asociación de Subredes con Tablas de Enrutamiento
# =====================================================
# Asocia cada subred pública a la tabla de enrutamiento
# pública y cada subred privada a su tabla correspondiente.

resource "aws_route_table_association" "publica_1" {
  subnet_id      = aws_subnet.publica_1.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "publica_2" {
  subnet_id      = aws_subnet.publica_2.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "publica_3" {
  subnet_id      = aws_subnet.publica_3.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "privada_1" {
  subnet_id      = aws_subnet.privada_1.id
  route_table_id = aws_route_table.privada_1.id
}

resource "aws_route_table_association" "privada_2" {
  subnet_id      = aws_subnet.privada_2.id
  route_table_id = aws_route_table.privada_2.id
}

resource "aws_route_table_association" "privada_3" {
  subnet_id      = aws_subnet.privada_3.id
  route_table_id = aws_route_table.privada_3.id
}

# =====================================================
# Customer Gateway para VPN
# =====================================================
# Representa el dispositivo o servicio de VPN del cliente
# en las instalaciones (on-premises) que se conectará a
# la VPN de AWS.

resource "aws_customer_gateway" "principal" {
  bgp_asn    = var.vpn_bgp_asn
  ip_address = var.vpn_customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-cgw"
      Environment = var.environment
    }
  )
}

# =====================================================
# VPN Gateway (Virtual Private Gateway)
# =====================================================
# El VPN Gateway se adjunta a la VPC y permite la
# conexión VPN entre la VPC y la red del cliente.

resource "aws_vpn_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-vpg"
      Environment = var.environment
    }
  )
}

# =====================================================
# Adjuntar VPN Gateway a la VPC
# =====================================================

resource "aws_vpn_gateway_attachment" "vpc_attachment" {
  vpc_id     = aws_vpc.principal.id
  vpn_gateway_id = aws_vpn_gateway.principal.id
}

# =====================================================
# Conexión VPN
# =====================================================
# La conexión VPN establece el túnel IPSec entre
# AWS y el gateway del cliente.

resource "aws_vpn_connection" "principal" {
  customer_gateway_id = aws_customer_gateway.principal.id
  vpn_gateway_id      = aws_vpn_gateway.principal.id
  type                = "ipsec.1"
  static_routes_only  = var.vpn_static_routes_only

  tunnel_inside_ip_version = "ipv4"

  tunnel_1 {
    pre_shared_key = var.vpn_preshared_key_1
    tunnel_inside_cidr = var.vpn_tunnel_cidr_1
  }

  tunnel_2 {
    pre_shared_key = var.vpn_preshared_key_2
    tunnel_inside_cidr = var.vpn_tunnel_cidr_2
  }

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-vpn"
      Environment = var.environment
    }
  )
}

# =====================================================
# Tabla de Enrutamiento para VPN
# =====================================================
# Permite el tráfico desde la VPN hacia las subredes
# privadas de la VPC.

resource "aws_route_table" "vpn" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = var.vpn_remote_network_cidr
    gateway_id = aws_vpn_gateway.principal.id
  }

  tags = merge(
    var.tags_defaults,
    {
      Name        = "${var.project_name}-${var.environment}-rt-vpn"
      Environment = var.environment
      Type        = "vpn"
    }
  )
}

# =====================================================
# Asociación de subredes privadas con tabla VPN
# =====================================================
# Las subredes privadas deben poder recibir tráfico
# desde la VPN para permitir la comunicación con los
# recursos internos de la VPC.

resource "aws_route_table_association" "vpn_privada_1" {
  subnet_id      = aws_subnet.privada_1.id
  route_table_id = aws_route_table.vpn.id
}

resource "aws_route_table_association" "vpn_privada_2" {
  subnet_id      = aws_subnet.privada_2.id
  route_table_id = aws_route_table.vpn.id
}

resource "aws_route_table_association" "vpn_privada_3" {
  subnet_id      = aws_subnet.privada_3.id
  route_table_id = aws_route_table.vpn.id
}

// === ARCHIVO: outputs.tf ===
# =====================================================
# Outputs de la VPC
# =====================================================
# Expone los identificadores y configuraciones principales
# de la VPC para su uso en otros módulos o para referencia
# externa del proyecto.

output "vpc_id" {
  description = "Identificador de la VPC principal"
  value       = aws_vpc.principal.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = aws_vpc.principal.cidr_block
}

output "vpc_dns_hostnames_enabled" {
  description = "Indica si los nombres de host DNS están habilitados"
  value       = aws_vpc.principal.enable_dns_hostnames
}

output "vpc_dns_support_enabled" {
  description = "Indica si el soporte DNS está habilitado"
  value       = aws_vpc.principal.enable_dns_support
}

# =====================================================
# Outputs del Internet Gateway
# =====================================================

output "internet_gateway_id" {
  description = "Identificador del Internet Gateway"
  value       = aws_internet_gateway.principal.id
}

# =====================================================
# Outputs de Subredes Públicas
# =====================================================

output "subnet_publica_1_id" {
  description = "Identificador de la subred pública en AZ ${var.region}a"
  value       = aws_subnet.publica_1.id
}

output "subnet_publica_1_cidr" {
  description = "Bloque CIDR de la subred pública en AZ ${var.region}a"
  value       = aws_subnet.publica_1.cidr_block
}

output "subnet_publica_2_id" {
  description = "Identificador de la subred pública en AZ ${var.region}b"
  value       = aws_subnet.publica_2.id
}

output "subnet_publica_2_cidr" {
  description = "Bloque CIDR de la subred pública en AZ ${var.region}b"
  value       = aws_subnet.publica_2.cidr_block
}

output "subnet_publica_3_id" {
  description = "Identificador de la subred pública en AZ ${var.region}c"
  value       = aws_subnet.publica_3.id
}

output "subnet_publica_3_cidr" {
  description = "Bloque CIDR de la subred pública en AZ ${var.region}c"
  value       = aws_subnet.publica_3.cidr_block
}

# =====================================================
# Outputs de Subredes Privadas
# =====================================================

output "subnet_privada_1_id" {
  description = "Identificador de la subred privada en AZ ${var.region}a"
  value       = aws_subnet.privada_1.id
}

output "subnet_privada_1_cidr" {
  description = "Bloque CIDR de la subred privada en AZ ${var.region}a"
  value       = aws_subnet.privada_1.cidr_block
}

output "subnet_privada_2_id" {
  description = "Identificador de la subred privada en AZ ${var.region}b"
  value       = aws_subnet.privada_2.id
}

output "subnet_privada_2_cidr" {
  description = "Bloque CIDR de la subred privada en AZ ${var.region}b"
  value       = aws_subnet.privada_2.cidr_block
}

output "subnet_privada_3_id" {
  description = "Identificador de la subred privada en AZ ${var.region}c"
  value       = aws_subnet.privada_3.id
}

output "subnet_privada_3_cidr" {
  description = "Bloque CIDR de la subred privada en AZ ${var.region}c"
  value       = aws_subnet.privada_3.cidr_block
}

# =====================================================
# Outputs de NAT Gateways
# =====================================================

output "nat_gateway_1_id" {
  description = "Identificador del NAT Gateway en AZ ${var.region}a"
  value       = aws_nat_gateway.principal_1.id
}

output "nat_gateway_1_ip" {
  description = "Dirección IP elástica del NAT Gateway en AZ ${var.region}a"
  value       = aws_nat_gateway.principal_1.allocation_id
}

output "nat_gateway_2_id" {
  description = "Identificador del NAT Gateway en AZ ${var.region}b"
  value       = aws_nat_gateway.principal_2.id
}

output "nat_gateway_2_ip" {
  description = "Dirección IP elástica del NAT Gateway en AZ ${var.region}b"
  value       = aws_nat_gateway.principal_2.allocation_id
}

output "nat_gateway_3_id" {
  description = "Identificador del NAT Gateway en AZ ${var.region}c"
  value       = aws_nat_gateway.principal_3.id
}

output "nat_gateway_3_ip" {
  description = "Dirección IP elástica del NAT Gateway en AZ ${var.region}c"
  value       = aws_nat_gateway.principal_3.allocation_id
}

# =====================================================
# Outputs de Tablas de Enrutamiento
# =====================================================

output "route_table_publica_id" {
  description = "Identificador de la tabla de enrutamiento pública"
  value       = aws_route_table.publica.id
}

output "route_table_privada_1_id" {
  description = "Identificador de la tabla de enrutamiento privada para AZ ${var.region}a"
  value       = aws_route_table.privada_1.id
}

output "route_table_privada_2_id" {
  description = "Identificador de la tabla de enrutamiento privada para AZ ${var.region}b"
  value       = aws_route_table.privada_2.id
}

output "route_table_privada_3_id" {
  description = "Identificador de la tabla de enrutamiento privada para AZ ${var.region}c"
  value       = aws_route_table.privada_3.id
}

output "route_table_vpn_id" {
  description = "Identificador de la tabla de enrutamiento para VPN"
  value       = aws_route_table.vpn.id
}

# =====================================================
# Outputs de VPN
# =====================================================

output "vpn_gateway_id" {
  description = "Identificador del VPN Gateway"
  value       = aws_vpn_gateway.principal.id
}

output "vpn_connection_id" {
  description = "Identificador de la conexión VPN"
  value       = aws_vpn_connection.principal.id
}

output "vpn_customer_gateway_id" {
  description = "Identificador del Customer Gateway"
  value       = aws_customer_gateway.principal.id
}

output "vpn_tunnel_1_status" {
  description = "Estado del túnel VPN 1"
  value       = aws_vpn_connection.principal.tunnel_1_status
}

output "vpn_tunnel_2_status" {
  description = "Estado del túnel VPN 2"
  value       = aws_vpn_connection.principal.tunnel_2_status
}

output "vpn_remote_network_cidr" {
  description = "Bloque CIDR de la red remota del cliente para VPN"
  value       = var.vpn_remote_network_cidr
}

// === ARCHIVO: backend.tf ===
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


// === ARCHIVO: README.md ===
# Configuración de VPC en AWS - Proyecto de Cloud Ops

## Descripción del Proyecto

Este proyecto implementa la infraestructura de red básica en AWS mediante Terraform, creando una VPC con segmentación de subredes públicas y privadas, conectividad a internet y acceso remoto seguro mediante VPN.

## Estructura del Proyecto

```
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── qa/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── vpn/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Diagrama de Topología de Red

```
                                    Internet
                                        │
                                        ▼
                              ┌─────────────────┐
                              │   Internet      │
                              │   Gateway       │
                              │   (IGW)         │
                              └────────┬────────┘
                                       │
                    ┌──────────────────┼──────────────────┐
                    │                  │                  │
                    ▼                  ▼                  ▼
           ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
           │  Public Subnet 1 │   │  Public Subnet 2 │   │  Public Subnet 3 │
           │  10.0.1.0/24   │   │  10.0.2.0/24   │   │  10.0.3.0/24   │
           └──────────────┘   └──────────────┘   └──────────────┘
                    │                  │                  │
                    │        ┌─────────┴─────────┐        │
                    │        │   NAT Gateway(s)  │        │
                    │        │   (una por AZ)    │        │
                    │        └─────────┬─────────┘        │
                    │                  │                  │
                    ▼                  ▼                  ▼
           ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
           │ Private Subnet 1│   │ Private Subnet 2│   │ Private Subnet 3│
           │ 10.0.101.0/24  │   │ 10.0.102.0/24  │   │ 10.0.103.0/24  │
           └──────────────┘   └──────────────┘   └──────────────┘
                    │
                    ▼
            ┌──────────────┐
            │  VPN Gateway │
            │  (Client VPN)│
            └──────────────┘
                    │
                    ▼
           ┌──────────────┐
           │  Cliente     │
           │  Remoto      │
           └──────────────┘

Zona de Disponibilidad: us-east-1
├── us-east-1a: Public (10.0.1.0/24), Private (10.0.101.0/24)
├── us-east-1b: Public (10.0.2.0/24), Private (10.0.102.0/24)
└── us-east-1c: Public (10.0.3.0/24), Private (10.0.103.0/24)
```

## Requisitos Previos

- Terraform >= 1.5 instalado localmente
- Credenciales de AWS configuradas con permisos adecuados
- Bucket S3 para almacenar el estado remoto
- Tabla DynamoDB para bloqueo de estado

## Configuración de Credenciales AWS

Las credenciales se configuran mediante variables de entorno:

```bash
export AWS_ACCESS_KEY_ID="tu_access_key"
export AWS_SECRET_ACCESS_KEY="tu_secret_key"
export AWS_REGION="us-east-1"
```

O mediante el archivo de credenciales de AWS CLI en `~/.aws/credentials`.

## Configuración del Backend Remoto

El proyecto utiliza S3 para almacenar el estado de Terraform y DynamoDB para el bloqueo de estado. La configuración se encuentra en `backend.tf`.

Asegúrate de crear el bucket S3 y la tabla DynamoDB antes de ejecutar Terraform:

```bash
# Crear bucket S3 para estado
aws s3 mb s3://tu-bucket-terraform-state --region us-east-1

# Crear tabla DynamoDB para bloqueo
aws dynamodb create-table \
    --table-name terraform-state-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region us-east-1
```

## Comandos Básicos de Terraform

### Inicializar el directorio de trabajo

```bash
terraform init
```

Este comando descarga los providers necesarios y configura el backend remoto.

### Validar la configuración

```bash
terraform validate
```

Verifica que los archivos de configuración sean sintácticamente válidos.

### Formatear archivos de configuración

```bash
terraform fmt
```

Formatea automáticamente los archivos .tf para seguir las convenciones de estilo.

### Verificar formato sin aplicar cambios

```bash
terraform fmt -check
```

### Planificar los cambios

```bash
terraform plan -var-file="environments/dev/terraform.tfvars"
```

Genera un plan de ejecución mostrando los recursos que se crearán, modificarán o eliminarán.

### Aplicar la configuración

```bash
terraform apply -var-file="environments/dev/terraform.tfvars"
```

Aplica los cambios necesarios para alcanzar el estado deseado. Requiere confirmación.

### Aplicar sin confirmación interactiva

```bash
terraform apply -var-file="environments/dev/terraform.tfvars" -auto-approve
```

### Destruir los recursos

```bash
terraform destroy -var-file="environments/dev/terraform.tfvars"
```

Elimina todos los recursos creados por Terraform.

## Ambientes de Despliegue

El proyecto soporta tres ambientes: desarrollo, QA y producción. Cada ambiente tiene su propio archivo de variables.

### Desarrollo (dev)

```bash
terraform plan -var-file="environments/dev/terraform.tfvars"
terraform apply -var-file="environments/dev/terraform.tfvars"
```

### QA

```bash
terraform plan -var-file="environments/qa/terraform.tfvars"
terraform apply -var-file="environments/qa/terraform.tfvars"
```

### Producción

```bash
terraform plan -var-file="environments/prod/terraform.tfvars"
terraform apply -var-file="environments/prod/terraform.tfvars"
```

## Variables de Configuración

Las principales variables configurables se encuentran en `variables.tf` y sus valores se definen en los archivos `terraform.tfvars` de cada ambiente:

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `environment` | Nombre del ambiente | dev, qa, prod |
| `project_name` | Nombre del proyecto | mi-proyecto |
| `aws_region` | Región de AWS | us-east-1 |
| `vpc_cidr` | CIDR de la VPC | 10.0.0.0/16 |
| `availability_zones` | Zonas de disponibilidad | ["us-east-1a", "us-east-1b", "us-east-1c"] |
| `public_subnets` | CIDRs de subredes públicas | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] |
| `private_subnets` | CIDRs de subredes privadas | ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] |
| `enable_vpn` | Habilitar VPN | true |
| `customer_gateway_ip` | IP pública del gateway del cliente | 203.0.113.50 |

## Outputs Disponibles

Después de aplicar la configuración, Terraform mostrará los siguientes outputs:

- `vpc_id`: ID de la VPC creada
- `vpc_cidr`: Bloque CIDR de la VPC
- `public_subnet_ids`: IDs de las subredes públicas
- `private_subnet_ids`: IDs de las subredes privadas
- `nat_gateway_ids`: IDs de los NAT Gateways
- `internet_gateway_id`: ID del Internet Gateway
- `vpn_gateway_id`: ID del VPN Gateway (si está habilitado)

## Consideraciones de Seguridad

- Las subredes privadas no tienen acceso directo a internet
- El tráfico saliente de subredes privadas sale por NAT Gateway
- La VPN proporciona acceso seguro cifrado a la infraestructura
- Todos los recursos tienen etiquetas para seguimiento de costos

## Optimización de Costos

- Los NAT Gateways tienen costo por hora y por GB procesado
- La VPN tiene costo por conexión activa
- UsarReserved Instances o Savings Plans para cargas predecibles
- Revisar regularmente recursos sin uso

## Referencias

- Documentación oficial de Terraform: https://www.terraform.io/docs
- Documentación de AWS VPC: https://docs.aws.amazon.com/vpc/
- Mejores prácticas de AWS Well-Architected: https://aws.amazon.com/architecture/well-architected/


// === ARCHIVO: modules/vpc/main.tf ===
# Módulo de VPC: crea la infraestructura de red base con segmentación
# de subredes públicas y privadas, conectividad a internet y NAT.

# VPC principal con CIDR block configurable
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpc-${var.environment}"
      Description = "VPC principal para ${var.project_name} ambiente ${var.environment}"
      Environment = var.environment
    }
  )
}

# Internet Gateway para conectividad pública
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-igw-${var.environment}"
      Description = "Internet Gateway para acceso a internet"
    }
  )
}

# Subredes públicas - una por cada AZ配置
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-public-subnet-${count.index + 1}-${var.environment}"
      Description = "Subred pública en AZ ${var.availability_zones[count.index]}"
      Type        = "public"
      Environment = var.environment
    }
  )
}

# Subredes privadas - una por cada AZ
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, length(var.availability_zones) + count.index)
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-subnet-${count.index + 1}-${var.environment}"
      Description = "Subred privada en AZ ${var.availability_zones[count.index]}"
      Type        = "private"
      Environment = var.environment
    }
  )
}

# Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? length(var.availability_zones) : 0

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-eip-nat-${count.index + 1}-${var.environment}"
      Description = "EIP para NAT Gateway ${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateways - uno por AZ para alta disponibilidad
resource "aws_nat_gateway" "main" {
  count = var.enable_nat_gateway ? length(var.availability_zones) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-nat-gw-${count.index + 1}-${var.environment}"
      Description = "NAT Gateway para subred privada en AZ ${var.availability_zones[count.index]}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# Tabla de enrutamiento para subredes públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-public-rt-${var.environment}"
      Description = "Tabla de enrutamiento pública"
      Type        = "public"
      Environment = var.environment
    }
  )
}

# Asociación de subredes públicas con tabla de rutas pública
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Tabla de enrutamiento para subredes privadas
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-rt-${var.environment}"
      Description = "Tabla de enrutamiento privada"
      Type        = "private"
      Environment = var.environment
    }
  )
}

# Crear tablas de enrutamiento privadas adicionales por NAT Gateway
resource "aws_route_table" "private_with_nat" {
  count = var.enable_nat_gateway && length(var.availability_zones) > 1 ? length(var.availability_zones) - 1 : 0

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index + 1].id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-rt-nat-${count.index + 2}-${var.environment}"
      Description = "Tabla de enrutamiento privada con NAT ${count.index + 2}"
      Type        = "private"
      Environment = var.environment
    }
  )
}

# Asociación de subredes privadas con tabla de rutas privada principal
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  # Asignar la primera subred privada a la tabla principal
  # Las demás subredes privadas se asignan a sus tablas correspondientes
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = count.index == 0 ? aws_route_table.private.id : aws_route_table.private_with_nat[count.index - 1].id
}

// === ARCHIVO: modules/vpc/outputs.tf ===
# Outputs del módulo VPC - exponen los IDs y ARNs necesarios
# para que otros módulos y el main.tf consuman estos valores.

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_default_security_group_id" {
  description = "ID del security group por defecto de la VPC"
  value       = aws_vpc.main.default_security_group_id
}

output "vpc_default_network_acl_id" {
  description = "ID del Network ACL por defecto de la VPC"
  value       = aws_vpc.main.default_network_acl_id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "Lista de CIDR blocks de subredes públicas"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  description = "Lista de CIDR blocks de subredes privadas"
  value       = aws_subnet.private[*].cidr_block
}

output "nat_gateway_ids" {
  description = "Lista de IDs de los NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_ips" {
  description = "Lista de IPs públicas de los NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada principal"
  value       = aws_route_table.private.id
}

output "availability_zones" {
  description = "Lista de AZs utilizadas"
  value       = var.availability_zones
}

// === ARCHIVO: modules/vpn/main.tf ===
# Módulo de VPN: configura la conectividad remota segura a la VPC
# mediante AWS Site-to-Site VPN, incluyendo Customer Gateway y conexión.

# Customer Gateway - representa el dispositivo de VPN del cliente
resource "aws_customer_gateway" "main" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-cgw-${var.environment}"
      Description = "Customer Gateway para VPN remota"
      Environment = var.environment
    }
  )
}

# VPN Connection - establece el túnel VPN entre AWS y el Customer Gateway
resource "aws_vpn_connection" "main" {
  customer_gateway_id = aws_customer_gateway.main.id
  type                = "ipsec.1"
  static_routes_only  = var.static_routes_only

  # Opciones de túnel
  tunnel1_preshared_key = var.tunnel1_preshared_key != "" ? var.tunnel1_preshared_key : random_string.tunnel1_key.result
  tunnel2_preshared_key = var.tunnel2_preshared_key != "" ? var.tunnel2_preshared_key : random_string.tunnel2_key.result

  tunnel1_inside_cidr = var.tunnel_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr != "" ? var.tunnel2_inside_cidr : cidrsubnet(var.tunnel_inside_cidr, 8, 1)

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpn-${var.environment}"
      Description = "VPN Connection para conectividad remota"
      Environment = var.environment
    }
  )
}

# Transit Gateway - necesario para conectar múltiples VPCs o para VPN de alta disponibilidad
resource "aws_ec2_transit_gateway" "main" {
  count = var.enable_transit_gateway ? 1 : 0

  amazon_asn             = var.transit_gateway_asn
  description            = "Transit Gateway para ${var.project_name} - ${var.environment}"
  dns_support            = "enable"
  vpn_ecmp_support       = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-${var.environment}"
      Description = "Transit Gateway para conectividad de VPN"
      Environment = var.environment
    }
  )
}

# Asociación del Transit Gateway con la VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_id = aws_ec2_transit_gateway.main[0].id
  vpc_id             = var.vpc_id
  subnet_ids         = var.transit_gateway_subnet_ids

  dns_support   = "enable"
  ipv6_support  = "disable"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-attachment-${var.environment}"
      Description = "Attachment de Transit Gateway a VPC"
      Environment = var.environment
    }
  )
}

# Attach de la VPN al Transit Gateway
resource "aws_ec2_transit_gateway_vpn_attachment" "main" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_id     = aws_ec2_transit_gateway.main[0].id
  vpn_connection_id      = aws_vpn_connection.main.id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-vpn-attachment-${var.environment}"
      Description = "Attachment de VPN a Transit Gateway"
      Environment = var.environment
    }
  )
}

# Tabla de rutas de Transit Gateway para VPN
resource "aws_ec2_transit_gateway_route_table" "vpn" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_id = aws_ec2_transit_gateway.main[0].id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tgw-rt-vpn-${var.environment}"
      Description = "Tabla de rutas del Transit Gateway para VPN"
      Environment = var.environment
    }
  )
}

# Ruta en Transit Gateway para el tráfico de la VPN
resource "aws_ec2_transit_gateway_route" "vpn_route" {
  count = var.enable_transit_gateway ? 1 : 0

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpn[0].id
  destination_cidr_block         = var.vpn_destination_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpn_attachment.main[0].id
}

# Keys aleatorias para los túneles si no se proporcionan
resource "random_string" "tunnel1_key" {
  count   = var.tunnel1_preshared_key == "" ? 1 : 0
  length  = 16
  special = false
}

resource "random_string" "tunnel2_key" {
  count   = var.tunnel2_preshared_key == "" ? 1 : 0
  length  = 16
  special = false
}

# Route Table de la VPC para dirigir tráfico a través de la VPN
resource "aws_route" "vpn_route" {
  count = length(var.vpn_route_table_ids) > 0 ? 1 : 0

  route_table_id         = var.vpn_route_table_ids[0]
  destination_cidr_block = var.vpn_destination_cidr
  transit_gateway_id     = var.enable_transit_gateway ? aws_ec2_transit_gateway.main[0].id : null

  # Fallback a vpn_connection si no se usa transit gateway
  vpn_gateway_id = var.enable_transit_gateway ? null : aws_vpn_connection.main.id
}

# Security Group para la VPN endpoint
resource "aws_security_group" "vpn" {
  name        = "${var.project_name}-vpn-sg-${var.environment}"
  description = "Security Group para tráfico VPN"
  vpc_id      = var.vpc_id

  # Permitir tráfico IPSec (UDP 500, 4500)
  ingress {
    description = " IPSec IKE"
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = [var.customer_gateway_ip]
  }

  ingress {
    description = "IPSec NAT-T"
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = [var.customer_gateway_ip]
  }

  # Permitir tráfico GRE si se usa tunneling dinámico
  ingress {
    description = "GRE tunneling"
    from_port   = 0
    to_port     = 0
    protocol    = "gre"
    cidr_blocks = [var.customer_gateway_ip]
  }

  # Permitir todo el tráfico de salida
  egress {
    description = "Todo el tráfico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpn-sg-${var.environment}"
      Description = "Security Group para endpoints de VPN"
      Environment = var.environment
    }
  )
}


// === ARCHIVO: modules/vpn/outputs.tf ===
output "vpn_connection_id" {
  description = "Identificador único de la conexión VPN establecida"
  value       = aws_vpn_connection.main.id
}

output "vpn_connection_state" {
  description = "Estado actual de la conexión VPN"
  value       = aws_vpn_connection.main.state
}

output "customer_gateway_ip_address" {
  description = "Dirección IP pública del gateway del cliente para la conexión VPN"
  value       = var.customer_gateway_ip
}

output "vpn_tunnel_inside_ip_customer" {
  description = "Dirección IP interna del túnel VPN desde el lado del cliente"
  value       = aws_vpn_connection.main.tunnel1_inside_ip
}

output "vpn_tunnel_inside_ip_aws" {
  description = "Dirección IP interna del túnel VPN desde el lado de AWS"
  value       = aws_vpn_connection.main.tunnel1_aws_inside_ip
}

output "vpn_tunnel_2_inside_ip_customer" {
  description = "Dirección IP interna del segundo túnel VPN desde el lado del cliente"
  value       = aws_vpn_connection.main.tunnel2_inside_ip
}

output "vpn_tunnel_2_inside_ip_aws" {
  description = "Dirección IP interna del segundo túnel VPN desde el lado de AWS"
  value       = aws_vpn_connection.main.tunnel2_aws_inside_ip
}

output "vpn_preshared_key_tunnel_1" {
  description = "Clave pre-compartida para el túnel 1 de la conexión VPN"
  value       = aws_vpn_connection.main.tunnel1_preshared_key
  sensitive   = true
}

output "vpn_preshared_key_tunnel_2" {
  description = "Clave pre-compartida para el túnel 2 de la conexión VPN"
  value       = aws_vpn_connection.main.tunnel2_preshared_key
  sensitive   = true
}

output "vpn_remote_route" {
  description = "Ruta remota configurada para la conexión VPN"
  value       = aws_vpn_connection.main.remote_gateway_ip
}

output "vpn_static_routes" {
  description = "Rutas estáticas configuradas en la conexión VPN"
  value       = aws_vpn_connection.main.static_routes_only
}

output "customer_gateway_id" {
  description = "Identificador del gateway del cliente creado en AWS"
  value       = aws_customer_gateway.main.id
}

output "vpn_gateway_id" {
  description = "Identificador del VPN gateway adjunto a la VPC"
  value       = aws_vpn_gateway.main.id
}

output "vpn_gateway_arn" {
  description = "ARN del VPN gateway para referencias en otras partes de la infraestructura"
  value       = aws_vpn_gateway.main.arn
}

output "tunnel_status" {
  description = "Estado de ambos túneles de la conexión VPN"
  value       = {
    tunnel1 = aws_vpn_connection.main.tunnel1_status
    tunnel2 = aws_vpn_connection.main.tunnel2_status
  }
}

output "vpn_category" {
  description = "Categoría del servicio VPN proporcionado por AWS"
  value       = aws_vpn_connection.main.category
}

output "dns_server_ip" {
  description = "Servidores DNS configurados para la resolución de nombres a través de la VPN"
  value       = var.dns_server
}

output "vpn_enabled" {
  description = "Indicador booleano que confirma si la VPN está habilitada"
  value       = var.enable_vpn
}

// === ARCHIVO: environments/dev/terraform.tfvars ===
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

// === ARCHIVO: environments/qa/terraform.tfvars ===
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

// === ARCHIVO: environments/prod/terraform.tfvars ===
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

```
