## Monitoreo y Observabilidad

![flujo_de_monitoreo](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/monitoring_flow.png)

### Captura de Trazas y Registros

Los agentes templados utilizan [OpenTelemetry](https://opentelemetry.io/) y [OpenLLMetry](https://github.com/traceloop/openllmetry) para una observabilidad integral, emitiendo eventos a Google Cloud Trace y Google Cloud Logging. Cada interacción con LangChain y VertexAI está instrumentada (ver [`server.py`](server.py)), lo que permite un trazado detallado de los flujos de solicitudes en los agentes construidos con este marco.

Aprovechando el [CloudTraceSpanExporter](https://cloud.google.com/python/docs/reference/spanner/latest/opentelemetry-tracing), el marco captura y exporta datos de trazas. Para abordar las limitaciones de Cloud Trace ([límite de valor de atributo de 256 bytes](https://cloud.google.com/trace/docs/quotas#limits_on_spans)) y [Cloud Logging](https://cloud.google.com/logging/quotas) ([tamaño de entrada de registro de 256KB](https://cloud.google.com/logging/quotas)), se implementa una extensión personalizada del CloudTraceSpanExporter en [`app/utils/tracing.py`](app/utils/tracing.py).

Esta extensión mejora la observabilidad al:

- Crear una entrada de registro en Google Cloud Logging para cada evento capturado.
- Almacenar automáticamente los datos del evento en Google Cloud Storage cuando la carga útil supera los 256KB.

Las cargas útiles registradas están asociadas con la traza original, asegurando un acceso fluido desde la consola de Cloud Trace.

### Enrutador de Registros

Los eventos se envían a BigQuery a través de un [enrutador de registros](https://cloud.google.com/logging/docs/routing/overview) para almacenamiento y análisis a largo plazo. El despliegue del enrutador de registros se maneja mediante código Terraform en [deployment/terraform](../deployment/terraform).

### Tablero de Looker Studio

Una vez que los datos se escriben en BigQuery, se pueden usar para poblar un [tablero de Looker Studio](https://lookerstudio.google.com/c/reporting/fa742264-4b4b-4c56-81e6-a667dd0f853f/page/tEnnC).

Esta plantilla de tablero proporciona un punto de partida para construir visualizaciones personalizadas sobre los datos capturados.

## Descargo de Responsabilidad

**Nota:** Los agentes templados están diseñados para habilitar la observabilidad de *tu* caso de uso en tu Proyecto de Google Cloud. Google Cloud no registra, monitorea ni accede a ningún dato generado a partir de los recursos desplegados. Consulta los [Términos del Servicio de Google Cloud](https://cloud.google.com/terms/service-terms) para más detalles.
