# Pipeline de Ingesta de Datos para RAG

El Agent Starter Pack simplifica la incorporación de la ingesta de datos en tus proyectos de agentes. Esto es especialmente útil para agentes que requieren procesamiento y recuperación de documentos, como las aplicaciones de Generación Aumentada por Recuperación (RAG).

## Descripción General

La ingesta de datos automatiza:

-   Cargar datos desde diversas fuentes.
-   Procesar y dividir documentos en fragmentos.
-   Generar embeddings con Vertex AI.
-   Almacenar datos procesados y embeddings en **Vertex AI Search** o **Vertex AI Vector Search**.
-   Programar actualizaciones periódicas de datos.

## Cuándo Incluir la Ingesta de Datos

Considera la ingesta de datos si:

-   Tu agente necesita buscar o referenciar documentación extensa.
-   Estás desarrollando una aplicación basada en RAG.
-   La base de conocimiento de tu agente requiere actualizaciones periódicas.
-   Quieres mantener el contenido de tu agente actualizado y accesible.

## Uso

### Creación de Proyectos

Incluye la ingesta de datos durante la creación del proyecto de dos maneras:

1.  **Inclusión Automática**: Algunos agentes (por ejemplo, los diseñados para RAG como `agentic_rag`) la incluyen automáticamente debido a su naturaleza. Se te pedirá que selecciones un almacén de datos (`vertex_ai_search` o `vertex_ai_vector_search`) si no se especifica.

2.  **Inclusión Opcional**: Para otros agentes, añádela usando la bandera `--include-data-ingestion` y especifica el almacén de datos deseado con `--datastore` (o `-ds`):

    ```bash
    # Usando Vertex AI Search
    agent-starter-pack create my-agent-project --include-data-ingestion -ds vertex_ai_search

    # Usando Vertex AI Vector Search
    agent-starter-pack create my-agent-project --include-data-ingestion -ds vertex_ai_vector_search
    ```
    Si se omite `--datastore` al usar `--include-data-ingestion`, se te pedirá que elijas uno.

### Configuración de Infraestructura

El IaC de Terraform configura la infraestructura necesaria según el almacén de datos elegido:

-   **Vertex AI Search**: Almacenes de datos.
-   **Vertex AI Vector Search**: Índices, Endpoints de Índices y Buckets para datos en preparación.
-   Cuentas de servicio y permisos necesarios.
-   Buckets de almacenamiento para artefactos del pipeline.
-   Conjuntos de datos de BigQuery (si aplica).

## Primeros Pasos

1.  Crea tu proyecto con ingesta de datos, especificando tu almacén de datos:

    ```bash
    # Ejemplo con Vertex AI Search
    agent-starter-pack create my-project -ds vertex_ai_search

    # Ejemplo con Vertex AI Vector Search
    agent-starter-pack create my-project -ds vertex_ai_vector_search
    ```

2.  Sigue las instrucciones de configuración en el archivo `data_ingestion/README.md` generado. Despliega la infraestructura de Terraform (al menos en tu proyecto de desarrollo) antes de ejecutar el pipeline de datos.

## Más Información

-   [Pipelines de Vertex AI](https://cloud.google.com/vertex-ai/docs/pipelines/introduction) para la gestión de pipelines.
-   [Documentación de Vertex AI Search](https://cloud.google.com/generative-ai-app-builder/docs/enterprise-search-introduction) para capacidades de búsqueda.
-   [Documentación de Vertex AI Vector Search](https://cloud.google.com/vertex-ai/docs/vector-search/overview) para capacidades de bases de datos vectoriales.
