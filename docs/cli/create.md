# `create`

El Agent Starter Pack proporciona comandos CLI para ayudarte a crear y gestionar proyectos de agentes de IA.

## Comando Create

El comando `create` te ayuda a crear nuevos proyectos de agentes de IA basados en GCP a partir de plantillas.

```bash
agent-starter-pack create NOMBRE_DEL_PROYECTO [OPCIONES]
```

### Argumentos

- `NOMBRE_DEL_PROYECTO`: Nombre del proyecto a crear (debe tener 26 caracteres o menos, se convertirá a minúsculas).

### Opciones

Las siguientes opciones se solicitarán de forma interactiva si no se proporcionan en la línea de comandos:
- `--agent`, `-a`: Nombre o número del agente a usar. Muestra los agentes disponibles si se omite.
- `--deployment-target`, `-d`: Destino de despliegue (`agent_engine` o `cloud_run`). Se solicita si se omite.
- `--datastore`, `-ds`: Tipo de almacén de datos a usar (`vertex_ai_search`, `vertex_ai_vector_search`). Se solicita si se especifica `--include-data-ingestion` o si el agente seleccionado requiere la ingesta de datos y esta opción se omite.
- `--region`: Región de GCP para el despliegue. Por defecto es `us-central1`. Se solicita confirmación si no se especifica y no se usa `--auto-approve`.

La cuenta de GCP y el ID del proyecto se detectan automáticamente. Se te pedirá confirmarlos o cambiarlos a menos que uses `--auto-approve`.

Opciones adicionales:
- `--include-data-ingestion`, `-i`: Incluir componentes de la canalización de ingesta de datos en el proyecto. Si se especifica sin `--datastore`, se te pedirá seleccionar un almacén de datos. Algunos agentes requieren ingesta de datos y habilitarán esta opción automáticamente.
- `--debug`: Habilitar el registro de depuración.
- `--output-dir`, `-o`: Directorio de salida para el proyecto (por defecto: directorio actual).
- `--auto-approve`: Omitir las solicitudes de confirmación interactivas para las credenciales de GCP y la región.
- `--skip-checks`: Omitir las verificaciones de instalación de `uv`, autenticación de GCP y conexión a Vertex AI.

### Ejemplo de Uso

```bash
# Crear un nuevo proyecto de forma interactiva
agent-starter-pack create mi-proyecto-agente

# Crear con un agente específico, destino de despliegue, región e incluir ingesta de datos con Vertex AI Search
agent-starter-pack create mi-proyecto-agente -a agentic_rag -d cloud_run --region europe-west1 -i -ds vertex_ai_search

# Crear sin solicitudes interactivas (usa las credenciales de GCP detectadas)
agent-starter-pack create mi-otro-agente -a chat_agent -d agent_engine --auto-approve
```
