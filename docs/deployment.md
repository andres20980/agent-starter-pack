# Despliegue

El agente templado utiliza [**Terraform**](http://terraform.io) para definir y aprovisionar la infraestructura subyacente, mientras que [**Cloud Build**](https://cloud.google.com/build/) orquesta la integración continua y el despliegue continuo (CI/CD).

## Flujo de Trabajo de Despliegue

![Flujo de Trabajo de Despliegue](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/deployment_workflow.png)

**Descripción:**

1. Pipeline de CI (`deployment/ci/pr_checks.yaml`):

   - Se activa al crear/actualizar un pull request.
   - Ejecuta pruebas unitarias e integrales.

2. Pipeline de CD (`deployment/cd/staging.yaml`):

   - Se activa al hacer merge en la rama `main`.
   - Construye y sube la aplicación al Registro de Artefactos.
   - Despliega en el entorno de staging.
   - Realiza pruebas de carga.

3. Despliegue en Producción (`deployment/cd/deploy-to-prod.yaml`):
   - Se activa después de un despliegue exitoso en staging.
   - Requiere aprobación manual.
   - Despliega en el entorno de producción.

## Setup

> **Note:** For a streamlined one-command deployment of the entire CI/CD pipeline and infrastructure using Terraform, you can use the [`agent-starter-pack setup-cicd` CLI command](./cli/setup_cicd.md). Currently only supporting Github.

**Prerequisites:**

1. A set of Google Cloud projects:
   - Staging project
   - Production project
   - CI/CD project (can be the same as staging or production)
2. Terraform installed on your local machine
3. Enable required APIs in the CI/CD project. This will be required for the Terraform deployment:

   ```bash
   gcloud config set project $YOUR_CI_CD_PROJECT_ID
   gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com cloudbuild.googleapis.com secretmanager.googleapis.com
   ```

## Step-by-Step Guide

1. **Create a Git Repository using your favorite Git provider (GitHub, GitLab, Bitbucket, etc.)**

2. **Connect Your Repository to Cloud Build**
   For detailed instructions, visit: [Cloud Build Repository Setup](https://cloud.google.com/build/docs/repositories#whats_next).<br>

   ![Alt text](https://storage.googleapis.com/github-repo/generative-ai/sample-apps/e2e-gen-ai-app-starter-pack/connection_cb.gif)

3. **Configure Terraform Variables**

   - Edit [`deployment/terraform/vars/env.tfvars`](../terraform/vars/env.tfvars) with your Google Cloud settings.

   | Variable               | Description                                                     | Required |
   | ---------------------- | --------------------------------------------------------------- | :------: |
   | project_name           | Project name used as a base for resource naming                 |   Yes    |
   | prod_project_id        | **Production** Google Cloud Project ID for resource deployment. |   Yes    |
   | staging_project_id     | **Staging** Google Cloud Project ID for resource deployment.    |   Yes    |
   | cicd_runner_project_id | Google Cloud Project ID where CI/CD pipelines will execute.     |   Yes    |
   | region                 | Google Cloud region for resource deployment.                    |   Yes    |
   | host_connection_name   | Name of the host connection you created in Cloud Build          |   Yes    |
   | repository_name        | Name of the repository you added to Cloud Build                 |   Yes    |

   Other optional variables may include: telemetry and feedback log filters, service account roles, and for projects requiring data ingestion: pipeline cron schedule, pipeline roles, and datastore-specific configurations.

4. **Deploy Infrastructure with Terraform**

   - Open a terminal and navigate to the Terraform directory:

   ```bash
   cd deployment/terraform
   ```

   - Initialize Terraform:

   ```bash
   terraform init
   ```

   - Apply the Terraform configuration:

   ```bash
   terraform apply --var-file vars/env.tfvars
   ```

   - Type 'yes' when prompted to confirm

After completing these steps, your infrastructure will be set up and ready for deployment!

## Dev Deployment

For End-to-end testing of the application, including tracing and feedback sinking to BigQuery, without the need to trigger a CI/CD pipeline.

First, enable required Google Cloud APIs:
