{%- if cookiecutter.datastore_type == "vertex_ai_search" -%}
{%- set datastore_service_name = "Vertex AI Search" -%}
{%- elif cookiecutter.datastore_type == "vertex_ai_vector_search" -%}
{%- set datastore_service_name = "Vertex AI Vector Search" -%}
{%- else -%}
{%- set datastore_service_name = "Tu Almacén de Datos Configurado" -%}
{%- endif -%}

# Pipeline de Ingesta de Datos

Este pipeline automatiza la ingesta de datos en {{ datastore_service_name }}, simplificando el proceso de construcción de aplicaciones de Recuperación Aumentada por Generación (RAG).

Orquesta el flujo de trabajo completo: carga de datos, división en segmentos manejables, generación de embeddings utilizando Vertex AI Embeddings e importación de los datos procesados en tu almacén de datos {{ datastore_service_name }}.

Puedes activar el pipeline para una carga inicial de datos o programarlo para que se ejecute periódicamente, asegurando que tu índice de búsqueda se mantenga actualizado. Vertex AI Pipelines proporciona las capacidades de orquestación y monitoreo para este proceso.

## Requisitos Previos

Antes de ejecutar cualquier comando, asegúrate de haber configurado tu ID de Proyecto de Google Cloud como una variable de entorno. Esta variable será utilizada por los comandos `make` posteriores.

```bash
export PROJECT_ID="TU_ID_DE_PROYECTO"
```
Reemplaza `"TU_ID_DE_PROYECTO"` con tu ID de Proyecto de Google Cloud real.

Ahora, puedes configurar el entorno de desarrollo:

1.  **Configurar el Entorno de Desarrollo:** Usa el siguiente comando desde la raíz del repositorio para aprovisionar los recursos necesarios en tu entorno de desarrollo utilizando Terraform. Esto incluye desplegar un almacén de datos y configurar los permisos requeridos.

    ```bash
    make setup-dev-env
    ```
    Este comando requiere que `terraform` esté instalado y configurado.

## Ejecución del Pipeline de Ingesta de Datos

Después de configurar la infraestructura utilizando `make setup-dev-env`, puedes ejecutar el pipeline de ingesta de datos.

> **Nota:** La ejecución inicial del pipeline puede tardar más tiempo mientras tu proyecto se configura para Vertex AI Pipelines.

**Pasos:**

**a. Ejecutar el Pipeline:**
Ejecuta el siguiente comando desde la raíz del repositorio. Asegúrate de que la variable de entorno `PROJECT_ID` siga configurada en tu sesión actual de shell (como se indicó en los Requisitos Previos).

```bash
make data-ingestion
```

Este comando se encarga de instalar las dependencias (si es necesario, a través de `make install`) y de enviar el trabajo del pipeline utilizando la configuración derivada de tu proyecto. Los parámetros específicos que se pasan al script subyacente dependen del `datastore_type` seleccionado durante la generación del proyecto:
{%- if cookiecutter.datastore_type == "vertex_ai_search" %}
*   Utilizará parámetros como `--data-store-id`, `--data-store-region`.
{%- elif cookiecutter.datastore_type == "vertex_ai_vector_search" %}
*   Utilizará parámetros como `--vector-search-index`, `--vector-search-index-endpoint`, `--vector-search-data-bucket-name`.
{%- endif %}
*   Los parámetros comunes incluyen `--project-id`, `--region`, `--service-account`, `--pipeline-root` y `--pipeline-name`.

**b. Programación del Pipeline:**

El comando `make data-ingestion` activa una ejecución inmediata del pipeline. Para entornos de producción, el script subyacente `submit_pipeline.py` también admite opciones de programación con flags como `--schedule-only` y `--cron-schedule` para ejecuciones periódicas.

**c. Monitoreo del Progreso del Pipeline:**

La configuración del pipeline y el enlace al estado de ejecución se imprimirán en la consola tras el envío. Para un monitoreo detallado, utiliza el panel de Vertex AI Pipelines en la Consola de Google Cloud.

## Prueba de Tu Aplicación RAG

Una vez que el pipeline de ingesta de datos se complete con éxito, puedes probar tu aplicación RAG con {{ datastore_service_name }}.
{%- if cookiecutter.datastore_type == "vertex_ai_search" %}
> **Resolución de Problemas:** Si encuentras el error `"google.api_core.exceptions.InvalidArgument: 400 The embedding field path: embedding not found in schema"` después de la ingesta inicial de datos, espera unos minutos e inténtalo de nuevo. Este retraso permite que Vertex AI Search indexe completamente los datos ingeridos.
{%- endif %}