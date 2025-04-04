# `setup-cicd`

El comando `setup-cicd` es una potente utilidad proporcionada por `agent-starter-pack` que automatiza el despliegue de toda tu infraestructura de Terraform y configura tus proyectos de Google Cloud en una sola operación.

**⚡️ Ejemplo Rápido:**

El comando ahora es aún más sencillo de usar. Puedes ejecutarlo sin argumentos, y te pedirá los IDs de los proyectos necesarios:

```bash
agent-starter-pack setup-cicd
```
*(Se te pedirá que introduzcas los IDs de los proyectos de Staging y Producción)*

Alternativamente, puedes proporcionar los IDs de los proyectos directamente como flags:

```bash
agent-starter-pack setup-cicd \
  --staging-project=tu-id-proyecto-staging \
  --prod-project=tu-id-proyecto-produccion
```

**⚠️ Consideraciones Importantes:**

*   **Experimental:** Este comando está en desarrollo activo. Úsalo con precaución y reporta cualquier problema.
*   **Uso en Producción:** Para entornos de producción, **recomendamos encarecidamente** seguir las instrucciones detalladas en `deployment/README.md`. La configuración manual ofrece mayor control sobre la seguridad y la configuración. Este comando automatizado es más adecuado para desarrollo y pruebas.
*   **Solo GitHub:** Actualmente, solo se admite GitHub como proveedor de Git.

### Requisitos Previos

1.  **Ejecutar desde la Raíz del Proyecto:** Ejecuta el comando desde el directorio raíz de tu proyecto `agent-starter-pack` (donde se encuentra `pyproject.toml`).
2.  **Instalar Herramientas:**
    *   Terraform
    *   CLI de `gh` (GitHub CLI): Instálalo y autentícate usando `gh auth login`.
    *   CLI de `gcloud` (Google Cloud SDK): Autentícate usando `gcloud auth application-default login`.
3.  **Proyectos de Google Cloud:** Necesitas al menos dos proyectos de Google Cloud: uno para staging y otro para producción. El comando te pedirá sus IDs si no proporcionas los flags `--staging-project` y `--prod-project`. También necesitas un proyecto para alojar los recursos de CI/CD (Cloud Build, Artifact Registry, estado de Terraform). Puedes especificarlo usando `--cicd-project`. Si se omite, se usará el proyecto de producción para los recursos de CI/CD.
4.  **Permisos:** El usuario o cuenta de servicio que ejecute este comando debe tener el rol de `Propietario` en los proyectos de Google Cloud especificados (staging, producción, CI/CD si se especifica, desarrollo si se especifica). Esto es necesario para crear recursos y asignar roles de IAM.

### Cómo Funciona

El comando `setup-cicd` automatiza lo siguiente:

1.  **Integración con GitHub:** Crea un nuevo repositorio privado en GitHub o se conecta a uno existente (solicitando detalles si es necesario).
2.  **Confirmación de IDs de Proyectos:** Solicita los IDs de los proyectos de Staging y Producción si no se proporcionan mediante flags.
3.  **Conexión con Cloud Build:** Configura una conexión de Cloud Build con tu repositorio de GitHub.
4.  **Configuración de Terraform:**
    *   Configura Terraform para gestionar tu infraestructura de CI/CD (triggers de Cloud Build, permisos de IAM, etc.) y, opcionalmente, un entorno de desarrollo (si se proporciona `--dev-project`).
    *   Por defecto, configura la gestión remota del estado de Terraform usando un bucket de Google Cloud Storage (GCS) en tu proyecto de CI/CD (`<CICD_PROJECT_ID>-terraform-state`). Usa `--local-state` para no usar esta opción.
5.  **Despliegue de Recursos:** Ejecuta `terraform apply` para crear los recursos necesarios en Google Cloud y configurar la conexión con el repositorio de GitHub.
6.  **Configuración Local de Git:** Inicializa un repositorio Git localmente (si es necesario) y añade el repositorio de GitHub como remoto `origin`.

### Ejecución del Comando

```bash
agent-starter-pack setup-cicd \
    [--staging-project <ID_DE_TU_PROYECTO_STAGING>] \
    [--prod-project <ID_DE_TU_PROYECTO_PRODUCCION>] \
    [--cicd-project <ID_DE_TU_PROYECTO_CICD>] \
    [--dev-project <ID_DE_TU_PROYECTO_DESARROLLO>] \
    [--region <REGION_GCP>] \
    [--repository-name <NOMBRE_REPOSITORIO_GITHUB>] \
    [--repository-owner <USUARIO_O_ORG_GITHUB>] \
    [--local-state] \
    [--auto-approve] \
    [--debug]
```

**Opciones Clave:**

*   `--staging-project`, `--prod-project`: **Información Obligatoria.** IDs de tus proyectos de Google Cloud para los entornos de staging y producción. El comando te pedirá estos datos si se omiten los flags.
*   `--cicd-project`: (Opcional) ID del proyecto para alojar los recursos de CI/CD (Cloud Build, Artifact Registry, bucket de estado de Terraform). Si se omite, se usa por defecto el ID del proyecto de producción (proporcionado mediante flag o solicitud).
*   `--dev-project`: (Opcional) ID del proyecto para un entorno de desarrollo dedicado gestionado por Terraform. Si se proporciona, Terraform también configurará recursos en este proyecto de desarrollo.
*   `--region`: (Opcional) Región de GCP para los recursos (por defecto: `us-central1`).
*   `--repository-name`: (Opcional) Nombre del repositorio de GitHub. Si se omite, se te pedirá o se generará un nombre.
*   `--repository-owner`: (Opcional) Tu nombre de usuario u organización en GitHub. Por defecto, se usa el usuario autenticado en `gh` si se omite.
*   `--local-state`: (Opcional) Usa archivos locales para el estado de Terraform en lugar del backend GCS predeterminado. No recomendado para colaboración.
*   `--auto-approve`: (Opcional) Omitir solicitudes interactivas (incluidas las de IDs de proyectos si se omiten los flags). Úsalo con cuidado.
*   `--debug`: (Opcional) Habilitar registro detallado.

*(Para uso avanzado/programático con conexiones preexistentes, consulta opciones como `--github-pat`, `--github-app-installation-id`, `--host-connection-name` ejecutando `agent-starter-pack setup-cicd --help`)*

### Después de Ejecutar el Comando

1.  **Commit y Push:** Esto es crucial para activar la canalización.
    ```bash
    git add .
    git commit -m "Commit inicial del agent starter pack"
    git push -u origin main
    ```
2.  **Verificar:** Revisa tu repositorio de GitHub y los proyectos de Google Cloud (Cloud Build > Triggers, Secret Manager, IAM) para ver los recursos creados.

### Configuración Manual de CI/CD (Recomendada para Producción)

Para despliegues robustos y listos para producción con control detallado sobre la seguridad, personalización y prácticas avanzadas de CI/CD, sigue la [guía de configuración manual](../deployment.md).
