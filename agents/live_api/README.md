# Agente Multimodal en Tiempo Real

Este patrón muestra un agente conversacional RAG en tiempo real impulsado por Google Gemini. El agente maneja interacciones de audio, vídeo y texto mientras utiliza llamadas a herramientas con una base de datos vectorial para respuestas fundamentadas.

![live_api_diagram](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/live_api_diagram.png)

**Componentes clave:**

- **Backend en Python** (en la carpeta `app/`): Un servidor listo para producción construido con [FastAPI](https://fastapi.tiangolo.com/) y [google-genai](https://googleapis.github.io/python-genai/) que incluye:

  - **Comunicación bidireccional en tiempo real** mediante WebSockets entre el frontend y el modelo Gemini
  - **Llamadas a herramientas integradas** con soporte para bases de datos vectoriales para la recuperación contextual de documentos
  - **Fiabilidad a nivel de producción** con lógica de reintentos y capacidades de reconexión automática
  - **Flexibilidad de despliegue** compatible con los endpoints de AI Studio y Vertex AI
  - **Endpoint de registro de comentarios** para recopilar interacciones de los usuarios

- **Frontend en React** (en la carpeta `frontend/`): Extiende la [Consola Web de la API en Tiempo Real Multimodal](https://github.com/google-gemini/multimodal-live-api-web-console), con características adicionales como **URLs personalizadas** y **recopilación de comentarios**.

![live api demo](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/live_api_pattern_demo.gif)

Una vez que tanto el backend como el frontend estén en funcionamiento, haz clic en el botón de reproducción en la interfaz del frontend para establecer una conexión con el backend. ¡Ahora puedes interactuar con el Agente Multimodal en Tiempo Real! Puedes intentar hacer preguntas como "Usando la herramienta que tienes, define Gobernanza en el contexto de MLOPs" para que el agente utilice la [documentación](https://cloud.google.com/architecture/deploy-operate-generative-ai-applications) que se le proporcionó.

## Recursos Adicionales para la API en Tiempo Real Multimodal

Explora estos recursos para aprender más sobre la API en Tiempo Real Multimodal y ver ejemplos de su uso:

- [Proyecto Pastra](https://github.com/heiko-hotz/gemini-multimodal-live-dev-guide/tree/main): una guía completa para desarrolladores sobre la API en Tiempo Real Multimodal de Gemini.
- [Demos y ejemplos de la API en Tiempo Real Multimodal de Google Cloud](https://github.com/GoogleCloudPlatform/generative-ai/tree/main/gemini/multimodal-live-api): Colección de ejemplos de código y aplicaciones de demostración que utilizan la API en Tiempo Real Multimodal en Vertex AI.
- [Cookbook de Gemini 2](https://github.com/google-gemini/cookbook/tree/main/gemini-2): Ejemplos prácticos y tutoriales para trabajar con Gemini 2.
- [Consola Web de la API en Tiempo Real Multimodal](https://github.com/google-gemini/multimodal-live-api-web-console): Interfaz web interactiva basada en React para probar y experimentar con la API en Tiempo Real Multimodal de Gemini.

## Estado Actual y Trabajo Futuro

Este patrón está en desarrollo activo. Las áreas clave planificadas para futuras mejoras incluyen:

*   **Observabilidad:** Implementación de características completas de monitoreo y trazabilidad.
*   **Pruebas de Carga:** Integración de capacidades de pruebas de carga.
