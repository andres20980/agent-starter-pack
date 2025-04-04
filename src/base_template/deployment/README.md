# README.md de Despliegue

Esta carpeta contiene la infraestructura como código y las configuraciones del pipeline CI/CD para desplegar una aplicación conversacional de IA Generativa en Google Cloud.

La aplicación utiliza [**Terraform**](http://terraform.io) para definir y aprovisionar la infraestructura subyacente, mientras que [**Cloud Build**](https://cloud.google.com/build/) orquesta el pipeline de integración y despliegue continuo (CI/CD).

## Flujo de Trabajo de Despliegue

![Flujo de Trabajo de Despliegue](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/deployment_workflow.png)

**Descripción:**

1. Pipeline de CI (`deployment/ci/pr_checks.yaml`):

   - Se activa al crear/actualizar una pull request
   - Ejecuta pruebas unitarias e integradas

2. Pipeline de CD (`deployment/cd/staging.yaml`):

   - Se activa al hacer merge en la rama `main`
   - Construye y sube la aplicación al Registro de Artefactos
   - Despliega en el entorno de staging
   - Realiza pruebas de carga

3. Despliegue en Producción (`deployment/cd/deploy-to-prod.yaml`):
   - Se activa tras un despliegue exitoso en staging
   - Requiere aprobación manual
   - Despliega en el entorno de producción

## Configuración

> **Nota:** Para un despliegue simplificado de un solo comando de todo el pipeline CI/CD y la infraestructura usando Terraform, puedes usar el [comando CLI `agent-starter-pack setup-cicd`](https://github.com/GoogleCloudPlatform/agent-starter-pack/blob/main/docs/cli/setup_cicd.md). Actualmente solo soporta Github.

**Requisitos Previos:**

1. Un conjunto de proyectos de Google Cloud:
   - Proyecto de staging
   - Proyecto de producción
   - Proyecto de CI/CD (puede ser el mismo que staging o producción)
2. Terraform instalado en tu máquina local
3. Habilitar las APIs requeridas en el proyecto de CI/CD. Esto será necesario para el despliegue con Terraform:

   ```bash
   gcloud config set project $YOUR_CI_CD_PROJECT_ID
   gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com cloudbuild.googleapis.com secretmanager.googleapis.com
   ```

## Guía Paso a Paso

1. **Crea un Repositorio Git usando tu proveedor de Git favorito (GitHub, GitLab, Bitbucket, etc.)**

2. **Conecta Tu Repositorio a Cloud Build**
   Para instrucciones detalladas, visita: [Configuración del Repositorio en Cloud Build](https://cloud.google.com/build/docs/repositories#whats_next).<br>

   ![Alt text](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/connection_cb.gif)

3. **Configura las Variables de Terraform**

   - Edita [`deployment/terraform/vars/env.tfvars`](../terraform/vars/env.tfvars) con tus configuraciones de Google Cloud.

   | Variable               | Descripción                                                     | Requerido |
   | ---------------------- | --------------------------------------------------------------- | :-------: |
   | project_name           | Nombre del proyecto usado como base para nombrar recursos       |    Sí     |
   | prod_project_id        | ID del Proyecto de Google Cloud **Producción** para el despliegue de recursos. |    Sí     |
   | staging_project_id     | ID del Proyecto de Google Cloud **Staging** para el despliegue de recursos.    |    Sí     |
   | cicd_runner_project_id | ID del Proyecto de Google Cloud donde se ejecutarán los pipelines CI/CD.     |    Sí     |
   | region                 | Región de Google Cloud para el despliegue de recursos.                    |    Sí     |
   | host_connection_name   | Nombre de la conexión del host que creaste en Cloud Build          |    Sí     |
   | repository_name        | Nombre del repositorio que añadiste a Cloud Build                 |    Sí     |

   Otras variables opcionales pueden incluir: filtros de registro de telemetría y feedback, roles de cuentas de servicio, y para proyectos que requieran ingestión de datos: cronograma del pipeline, roles del pipeline, y configuraciones específicas del almacén de datos.

4. **Despliega la Infraestructura con Terraform**

   - Abre una terminal y navega al directorio de Terraform:

   ```bash
   cd deployment/terraform
   ```

   - Inicializa Terraform:

   ```bash
   terraform init
   ```

   - Aplica la configuración de Terraform:

   ```bash
   terraform apply --var-file vars/env.tfvars
   ```

   - Escribe 'yes' cuando se te pida confirmación

Después de completar estos pasos, ¡tu infraestructura estará configurada y lista para el despliegue!

## Despliegue de Desarrollo

Para pruebas de extremo a extremo de la aplicación, incluyendo trazabilidad y registro de feedback en BigQuery, sin necesidad de activar un pipeline CI/CD.

Primero, habilita las APIs requeridas de Google Cloud:

```bash
gcloud config set project <your-dev-project-id>
gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com
```

Después de editar el archivo [`env.tfvars` relativo](../terraform/dev/vars/env.tfvars), sigue las siguientes instrucciones:

```bash
cd deployment/terraform/dev
terraform init
terraform apply --var-file vars/env.tfvars
```

Luego despliega la aplicación usando el siguiente comando (desde la raíz del repositorio):

```bash
make backend
```

### Video de Demostración de Extremo a Extremo

<a href="https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/template_deployment_demo.mp4">
  <img src="https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/preview_video.png" alt="Ver el video" width="300"/>
</a>
