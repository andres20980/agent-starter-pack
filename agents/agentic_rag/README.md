# RAG Agente

Este agente mejora el Agent Starter Pack con un pipeline de ingestión de datos listo para producción, enriqueciendo tus aplicaciones de Generación Aumentada por Recuperación (RAG). Podrás ingerir, procesar e incrustar datos personalizados, mejorando la relevancia y el contexto de tus respuestas generadas. Puedes elegir entre diferentes opciones de almacenamiento de datos, incluyendo Vertex AI Search y Vertex AI Vector Search, dependiendo de tus necesidades específicas.

El agente proporciona la infraestructura para crear un Pipeline de Vertex AI con tu código personalizado. Al estar construido sobre Vertex AI Pipelines, te beneficias de características como ejecuciones programadas, ejecuciones recurrentes y activaciones bajo demanda. Para procesar datos a escala de terabytes, recomendamos combinar Vertex AI Pipelines con herramientas de análisis de datos como BigQuery o Dataflow.

![demostración del agente de búsqueda](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/starter-pack-search-pattern.gif)

## Arquitectura

El agente implementa la siguiente arquitectura:

![diagrama de arquitectura](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/agentic_rag_vertex_ai_search_architecture.png)

### Características Clave

- **Opciones Flexibles de Almacenamiento de Datos:** Elige entre Vertex AI Search o Vertex AI Vector Search para un almacenamiento y recuperación de datos eficiente según tus necesidades específicas.
- **Pipeline Automatizado de Ingestión de Datos:** Automatiza el proceso de ingestión de datos desde fuentes de entrada.
- **Incrustaciones Personalizadas:** Genera incrustaciones utilizando Vertex AI Embeddings e incorpóralas a tus datos para una búsqueda semántica mejorada.
- **Despliegue con Terraform:** El pipeline de ingestión se instancia con Terraform junto con el resto de la infraestructura del paquete inicial.
- **Integración con Cloud Build:** El despliegue de pipelines de ingestión se añade a los pipelines de CD del paquete inicial.
- **Código Personalizable:** Adapta y personaliza fácilmente el código para ajustarlo a las necesidades específicas de tu aplicación y fuentes de datos.
