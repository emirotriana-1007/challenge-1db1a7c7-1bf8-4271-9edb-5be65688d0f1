# Configuración de una VPC en AWS

Como analista junior de Cloud Ops, necesitas configurar una VPC en AWS para un cliente que requiere conectividad a internet y segmentación de redes. Debes crear una VPC, definir subredes públicas y privadas, establecer reglas de enrutamiento y asegurar la conectividad remota a través de una VPN. El cliente tiene un tráfico esperado de 1 000 solicitudes por segundo en hora pico y requiere un SLA de 99.9%.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Configuración de Redes Básicas y Conectividad |
| **Nivel** | junior-l1 |
| **Tipo** | practical |
| **Tiempo estimado** | 4 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Creación de la VPC

**Objetivo:** Configurar una VPC con subredes públicas y privadas.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Identifica los requisitos de la VPC y las subredes.
- Crea una VPC con un CIDR block de 10.0.0.0/16.
- Define subredes públicas y privadas con los CIDR blocks 10.0.1.0/24 y 10.0.2.0/24 respectivamente.

**Entregable:** VPC configurada con subredes públicas y privadas.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda las mejores prácticas para el subneteo.
- Considera la segmentación de redes para mejorar la seguridad.

</details>

### Fase 2: Configuración de Reglas de Enrutamiento

**Objetivo:** Establecer reglas de enrutamiento para la conectividad a internet y la comunicación entre subredes.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Crea una tabla de enrutamiento para la subred pública.
- Agrega una ruta predeterminada (0.0.0.0/0) que apunte al gateway de internet.
- Crea una tabla de enrutamiento para la subred privada y establece una ruta que apunte a la subred pública.

**Entregable:** Tablas de enrutamiento configuradas para las subredes públicas y privadas.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda que la subred pública debe tener acceso a internet.
- La subred privada debe comunicarse con la subred pública para acceder a internet.

</details>

### Fase 3: Configuración de VPN

**Objetivo:** Configurar una VPN para asegurar la conectividad remota.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Crea un cliente VPN y configura las rutas necesarias para la conectividad remota.
- Asegura que la VPN pueda acceder a la VPC y a las subredes configuradas.

**Entregable:** VPN configurada para asegurar la conectividad remota a la VPC.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda las mejores prácticas para la configuración de VPN.
- Considera la seguridad y la latencia al configurar la VPN.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una VPC y por qué es importante en la configuración de redes en la nube?
- **paraQueSirve**: ¿Para qué sirve la segmentación de redes en una VPC?
- **comoSeUsa**: ¿Cómo se usa una tabla de enrutamiento para establecer la conectividad en una VPC?
- **erroresComunes**: ¿Cuáles son los errores comunes al configurar una VPN y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica la configuración de una VPC en términos de seguridad y rendimiento?

## Criterios de Evaluacion

- Configuración correcta de la VPC con subredes públicas y privadas.
- Establecimiento de reglas de enrutamiento para la conectividad a internet y la comunicación entre subredes.
- Configuración exitosa de una VPN para asegurar la conectividad remota.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
