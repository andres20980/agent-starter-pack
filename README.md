# 🚀 Paquete de Inicio para Agentes

![Versión](https://img.shields.io/pypi/v/agent-starter-pack?color=blue) [![Resumen de 1 Minuto](https://img.shields.io/badge/1--Minute%20Overview-gray)](https://youtu.be/jHt-ZVD660g) [![Documentación](https://img.shields.io/badge/Documentation-gray)](./docs/README.md) ![Estrellas](https://img.shields.io/github/stars/GoogleCloudPlatform/agent-starter-pack?color=yellow)


El `agent-starter-pack` es una colección de plantillas de agentes de IA generativa listas para producción, diseñadas para Google Cloud. <br>
Acelera el desarrollo proporcionando una solución integral y lista para producción, abordando desafíos comunes (Despliegue y Operaciones, Evaluación, Personalización, Observabilidad) en la construcción y despliegue de agentes de IA generativa.

| ⚡️ Lanzar | 🧪 Experimentar  | ✅ Desplegar | 🛠️ Personalizar |
|---|---|---|---|
| [Plantillas de agentes preconstruidas](./agents/) (ReAct, RAG, multi-agente, API Multimodal en Vivo). | [Evaluación con Vertex AI](https://cloud.google.com/vertex-ai/generative-ai/docs/models/evaluation-overview) y un entorno interactivo. | Infraestructura lista para producción con [monitorización, observabilidad](./docs/observability.md) y [CI/CD](./docs/deployment.md) en [Cloud Run](https://cloud.google.com/run) o [Agent Engine](https://cloud.google.com/vertex-ai/generative-ai/docs/agent-engine/overview). | Extiende y personaliza las plantillas según tus necesidades. |

---
 
## ⚡ Comienza en 1 Minuto

¿Listo para construir tu agente de IA? Simplemente ejecuta este comando:

```bash
# Crea y activa un entorno virtual de Python
python -m venv venv && source venv/bin/activate

# Instala el paquete de inicio para agentes
pip install agent-starter-pack

# Crea un nuevo proyecto de agente
agent-starter-pack create mi-agente-genial
```

**¡Eso es todo!** Ahora tienes un proyecto de agente completamente funcional, con backend, frontend e infraestructura de despliegue, listo para explorar y personalizar.
Para más opciones de instalación, consulta la [Guía de Instalación](docs/installation.md).

---

 🆕 El paquete de inicio ofrece soporte completo para Agent Engine, una nueva solución completamente gestionada para desplegar agentes. Simplemente ejecuta este comando para comenzar:

```bash
agent-starter-pack create mi-agente -d agent_engine -a langgraph_base_react
```


*Consulta la [lista completa de opciones](docs/cli/create.md) para más detalles.*

## 🤖 Agentes

| Nombre del Agente           | Descripción                                                                                                                       |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| `langgraph_base_react`      | Un agente que implementa un agente ReAct base utilizando LangGraph |
| `agentic_rag` | Un agente RAG que utiliza LangGraph para recuperación de documentos y preguntas y respuestas. Compatible con [Vertex AI Search](https://cloud.google.com/generative-ai-app-builder/docs/enterprise-search-introduction) y [Vector Search](https://cloud.google.com/vertex-ai/docs/vector-search/overview).       |
| `crewai_coding_crew`       | Un sistema multi-agente implementado con CrewAI creado para apoyar actividades de codificación       |
| `live_api`       | Un agente RAG multimodal en tiempo real impulsado por Gemini, que admite chat de audio/video/texto con respuestas respaldadas por una base de datos vectorial                       |

**¡Más agentes están en camino!** Estamos ampliando continuamente nuestra [biblioteca de agentes](./agents/). ¿Tienes en mente un tipo específico de agente? [¡Contribuye!](#contribuyendo)


#### Funciones Extra

El `agent-starter-pack` ofrece dos características clave para acelerar y simplificar el desarrollo de tu agente:

- **🔄 [Automatización CI/CD (Experimental)](docs/cli/setup_cicd.md)** - Un comando para configurar un pipeline completo de GitHub + Cloud Build para todos los entornos.
- **📥 [Pipeline de Datos para RAG con Terraform/CI-CD](docs/data-ingestion.md)** - Integra sin problemas un pipeline de datos para procesar embeddings para RAG en tu sistema de agentes. Compatible con [Vertex AI Search](https://cloud.google.com/generative-ai-app-builder/docs/enterprise-search-introduction) y [Vector Search](https://cloud.google.com/vertex-ai/docs/vector-search/overview).


## Arquitectura de Alto Nivel

Este paquete de inicio cubre todos los aspectos del desarrollo de agentes, desde la creación de prototipos y evaluación hasta el despliegue y la monitorización.

![Arquitectura de Alto Nivel](docs/images/ags_high_level_architecture.png "Arquitectura")

---

## 🔧 Requisitos

- Python 3.10+
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (para despliegue)


## 📚 Documentación
Consulta la [documentación](docs/) para más detalles:

- [¿Por qué usar el Paquete de Inicio?](docs/why_starter_pack.md)
- [Instalación](docs/installation.md)
- [Despliegue](docs/deployment.md)
- [Ingesta de Datos](docs/data-ingestion.md)
- [Observabilidad](docs/observability.md)
- [Referencia CLI](docs/cli/README.md)
- [Resolución de Problemas](docs/troubleshooting.md)

### Video Tutorial:

- **6 de marzo de 2025**: Un [video demo en directo de 120 minutos](https://www.youtube.com/watch?v=yIRIT_EtALs&t=235s) del nuevo `agent-starter-pack` donde construimos 3 agentes en menos de 30 minutos.
- **29 de octubre de 2024**: Un [video tutorial de 20 minutos](https://youtu.be/kwRG7cnqSu0) está disponible, mostrando la versión anterior del `agent-starter-pack`.

## Explora Más Recursos de IA Generativa

¿Buscas más ejemplos y recursos para IA Generativa en Google Cloud? Consulta el repositorio [GoogleCloudPlatform/generative-ai](https://github.com/GoogleCloudPlatform/generative-ai) para notebooks, ejemplos de código y más.

## Contribuyendo

¡Las contribuciones son bienvenidas! Consulta la [Guía de Contribución](CONTRIBUTING.md).

## Comentarios

¡Valoramos tus comentarios! Tu opinión nos ayuda a mejorar este paquete de inicio y hacerlo más útil para la comunidad.

### Obtener Ayuda

Si encuentras algún problema o tienes sugerencias específicas, considera primero [abrir un issue](https://github.com/GoogleCloudPlatform/generative-ai/issues) en nuestro repositorio de GitHub.

### Comparte tu Experiencia

Para otros tipos de comentarios, o si deseas compartir una experiencia positiva o una historia de éxito utilizando este paquete de inicio, ¡nos encantaría saber de ti! Puedes contactarnos en <a href="mailto:agent-starter-pack@google.com">agent-starter-pack@google.com</a>.

¡Gracias por tus contribuciones!

## Aviso Legal

Este repositorio es solo para fines demostrativos y no es un producto oficialmente soportado por Google.

## Términos de Servicio

La CLI de plantillas del paquete de inicio para agentes y las plantillas en este paquete de inicio utilizan APIs de Google Cloud. Al usar este paquete de inicio, estarás desplegando recursos en tu propio proyecto de Google Cloud y serás responsable de esos recursos. Por favor, revisa los [Términos de Servicio de Google Cloud](https://cloud.google.com/terms/service-terms) para más detalles sobre los términos de servicio asociados con estas APIs.
