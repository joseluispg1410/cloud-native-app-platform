**AKS + Terraform + Helm**

Breve guía para desplegar y exponer la aplicación demo usando Terraform (infraestructura), Helm (aplicación) y AKS (clúster).

**Resumen**
- **Objetivo:** Proveer comandos y pasos claros para autenticarse en Azure, construir la imagen, desplegar la app en AKS con Helm y exponerla mediante Ingress.

**Requisitos**
- **CLI:** `az`, `kubectl`, `helm`, `terraform`, `docker`
- **Python (opcional, para pruebas):** `python3`, `pip`.

**Estructura relevante del repositorio**
- [terraform](terraform)
- [helm/app](helm/app)
- [app/Dockerfile](app/Dockerfile)
- [app/src/app.py](app/src/app.py)
- [scripts/smoke_check.sh](scripts/smoke_check.sh)
- [tests](tests)

**Guía rápida — Pasos principales**

1) Autenticarse en Azure

```bash
az login
```

2) (Opcional) Autenticarse en Azure Container Registry (ACR)

Reemplaza `ACR_NAME` por el nombre de tu registro.

```bash
az acr login --name ACR_NAME
```

3) Obtener credenciales del clúster AKS

Reemplaza `RG_NAME` y `CLUSTER_NAME` según tu entorno.

```bash
az aks get-credentials --resource-group RG_NAME --name CLUSTER_NAME
kubectl get nodes
```

4) Construir y subir la imagen (si aplica)

Desde la carpeta `app`:

```bash
cd app
docker build -t ACR_NAME.azurecr.io/demo-app:latest .
docker push ACR_NAME.azurecr.io/demo-app:latest
```

5) Desplegar la aplicación con Helm

```bash
helm upgrade --install demo-app ./helm/app --namespace demo --create-namespace
```

6) Instalar Ingress Controller (NGINX) y exponer la app

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace

# Ver la IP pública (esperar a que el LoadBalancer tenga EXTERNAL-IP)
kubectl get svc -n ingress-nginx
```

Cuando `EXTERNAL-IP` esté disponible, añade un registro DNS o accede por IP.

**Terraform — Infraestructura**

La infraestructura (AKS, redes, etc.) está en el directorio [terraform](terraform).

# AKS + Terraform + Helm

Project summary
----------------
This repository contains infrastructure and deployment code to run a simple demo application on Azure Kubernetes Service (AKS). Terraform provisions the infrastructure (AKS, networking, etc.), Helm packages the application for Kubernetes, and the `app/` folder contains the application source and Dockerfile.

Quick overview:
- Provision AKS and related resources using Terraform (in `terraform/`).
- Build and push a Docker image to Azure Container Registry (ACR).
- Deploy the application with Helm (`helm/app`).
- Expose the app using an NGINX Ingress Controller.

Requirements
------------
- CLI tools: `az`, `kubectl`, `helm`, `terraform`, `docker`
- Optional for tests: `python3`, `pip`, `pytest`

Repository layout (relevant)
--------------------------
- [terraform](terraform) — Terraform configuration for infrastructure
- [helm/app](helm/app) — Helm chart for the demo application
- [app/Dockerfile](app/Dockerfile) — Docker image definition
- [app/src/app.py](app/src/app.py) — application source
- [scripts/smoke_check.sh](scripts/smoke_check.sh) — quick health check script
- [tests](tests) — unit / integration tests

Quickstart — Main steps
------------------------
1) Azure login

```bash
az login
```

2) (Optional) Login to Azure Container Registry (replace `ACR_NAME`)

```bash
az acr login --name ACR_NAME
```

3) Get AKS credentials (replace `RG_NAME` and `CLUSTER_NAME`)

```bash
az aks get-credentials --resource-group RG_NAME --name CLUSTER_NAME
kubectl get nodes
```

4) Build and push Docker image (from `app/`)

```bash
cd app
docker build -t ACR_NAME.azurecr.io/demo-app:latest .
docker push ACR_NAME.azurecr.io/demo-app:latest
```

5) Deploy application with Helm

```bash
helm upgrade --install demo-app ./helm/app --namespace demo --create-namespace
```

6) Install NGINX Ingress Controller and expose the app

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace

# Wait for the LoadBalancer EXTERNAL-IP to appear
kubectl get svc -n ingress-nginx
```

When the `EXTERNAL-IP` is available, configure DNS or access the app by IP.

Terraform — Infrastructure
--------------------------
All infrastructure code is under the [terraform](terraform) directory.

Basic workflow:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Local tests
-----------
Create a virtual environment, install dependencies and run tests:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r app/requirements.txt
pytest -q
```

Helpful scripts
---------------
- `scripts/smoke_check.sh` — quick health check for the deployed app

Next steps / suggestions
------------------------
- Replace placeholders (`ACR_NAME`, `RG_NAME`, `CLUSTER_NAME`) with real values.
- Add CI/CD (GitHub Actions, Azure Pipelines) to build/push images and deploy via Helm.
- Add documentation for Terraform variables in `terraform/variables.tf` if needed.

If you like, I can add a status badge, example `values.yaml` snippets, or create a GitHub Actions workflow for CI/CD.
