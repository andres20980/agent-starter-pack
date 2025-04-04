# Solución de Problemas

Esta guía ayuda a resolver problemas comunes con el Agent Starter Pack.

## Problemas de Autenticación

Para información detallada sobre la autenticación con Vertex AI, visita la [documentación oficial](https://cloud.google.com/vertex-ai/docs/authentication).

### Error "No se pudieron encontrar credenciales" o "No se pudo encontrar el proyecto"

**Problema**: Error de credenciales faltantes con Vertex AI.

**Solución**:

1. Inicia sesión en Google Cloud: `gcloud auth login --update-adc`
2. Configura el proyecto correcto:
    ```bash
    gcloud config set project YOUR_PROJECT_ID
    gcloud auth application-default set-quota-project YOUR_PROJECT_ID
    ```

### API de Vertex AI No Habilitada

**Problema**: Las operaciones fallan porque la API de Vertex AI no está habilitada en tu proyecto.

**Solución**:

1. Habilita la API de Vertex AI:
   ```bash
   gcloud services enable aiplatform.googleapis.com
   ```

2. Verifica que la API esté habilitada:
   ```bash
   gcloud services list --filter=aiplatform.googleapis.com
   ```

### Errores de Permiso Denegado
**Problema**: Errores de "Permiso denegado" con las APIs de Google Cloud.

**Solución**: Asegúrate de que tu usuario o cuenta de servicio tenga los roles necesarios de IAM. Por ejemplo, para Vertex AI, a menudo necesitas `roles/aiplatform.user`. Otorga roles usando el comando `gcloud projects add-iam-policy-binding` o la Consola de Cloud.

### Comando No Encontrado: agent-starter-pack

**Problema**: Error de "Comando no encontrado" después de la instalación.

**Solución**:

1. Verifica la instalación:
   ```bash
   pip list | grep agent-starter-pack
   ```
2. Revisa el PATH:
   ```bash
   echo $PATH
   ```
3. Reinstala si es necesario:
   ```bash
   pip install --user agent-starter-pack
   ```
4. Para pipx:
   ```bash
   pipx ensurepath
   source ~/.bashrc  # o ~/.zshrc
   ```

## Problemas de Creación de Proyectos

### Fallos en la Creación de Proyectos

**Problema**: `agent-starter-pack create` falla.

**Solución**:

1. **Revisa los Mensajes de Error:** Examina la salida para obtener pistas.
2. **Permisos de Escritura:** Asegúrate de tener acceso de escritura al directorio.
3. **Nombre del Proyecto:** Usa solo letras minúsculas, números y guiones.
4. **Modo Depuración:** Considera usar el modo de depuración para obtener información más detallada sobre el error:
    ```bash
    agent-starter-pack create my-project-name --debug
    ```

### Problemas con el Motor del Agente

Considera aprovechar la [documentación pública del producto](https://cloud.google.com/vertex-ai/generative-ai/docs/agent-engine/troubleshooting/set-up).

## Obtener Más Ayuda

Si los problemas persisten:

1. **Revisa los Issues de GitHub:** Busca problemas existentes en el repositorio de `agent-starter-pack` en GitHub.
2. **Crea un Nuevo Issue:** Proporciona:

    * Descripción del problema.
    * Pasos para reproducirlo.
    * Mensajes de error (preferiblemente ejecuta con el flag `--debug` para obtener registros detallados).
    * Entorno: SO, versión de Python, versión de `agent-starter-pack`, método de instalación, shell.
