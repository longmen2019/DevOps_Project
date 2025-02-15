
```markdown
# Decoupling CI from CD with ArgoCD Image Updater

This project demonstrates how to decouple Continuous Integration (CI) from Continuous Deployment (CD) using Argo CD Image Updater. By automating image updates, you can ensure your Kubernetes deployments are always running the latest version of your application, without manual intervention or complex CI/CD pipelines.

## Project Structure

* **nginx-demo-gitops:** This directory contains the following:
    * **nginx:** Contains the Helm chart for deploying the Nginx web server.
        * **Chart.yaml:** Defines the Helm chart metadata.
        * **values.yaml:** Contains configurable values for the Helm chart.
        * **templates:** Contains the Kubernetes manifests for the deployment and service.
            * **deployment.yaml:** Defines the Nginx deployment.
            * **service.yaml:** Exposes the Nginx deployment as a service.
    * **app.yaml:** The Argo CD Application manifest.
* **terraform (Optional):** Contains Terraform configuration for setting up Argo CD.
    * **0-provider.tf:** Defines the Terraform provider (Kubernetes).
    * **1-argocd.tf:** Defines the Argo CD deployment using the Helm chart.
    * **values/argocd.yaml:** Values for the Argo CD Helm chart.

## Prerequisites

* **Kubernetes Cluster:** You'll need a running Kubernetes cluster. This project uses Minikube for local development, but you can use any Kubernetes cluster (e.g., EKS, GKE, AKS).
* **kubectl:**  `kubectl` should be configured to connect to your Kubernetes cluster.
* **Helm (Optional):** Helm is only needed if you choose the Terraform installation method.
* **Argo CD:**  We provide two installation options: direct `kubectl apply` and Terraform.
* **Argo CD Image Updater:** Install the Argo CD Image Updater in your cluster.
* **Docker Hub Account:** You'll need a Docker Hub (or similar registry) account to store your container images.
* **Git Repository:** You'll need a Git repository to store your application code and Kubernetes manifests.

## Setup

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/longmen2022/nginx-demo-gitops.git](https://github.com/longmen2022/nginx-demo-gitops.git)
   cd nginx-demo-gitops
   ```

2. **Build and push the Nginx image:**
   ```bash
   docker build -t lmen776/nginx-demo1:v1.0 .  # Build the image
   docker login -u <your_dockerhub_username>   # Login to Docker Hub
   docker push lmen776/nginx-demo1:v1.0      # Push the image
   ```
   Replace `<your_dockerhub_username>` with your actual Docker Hub username.

3. **Install Argo CD (Choose ONE of the following methods):**

   **Method 1: Direct kubectl apply (Recommended for simple setups):**

   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f [https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml)
   # (Optional) Expose Argo CD using a NodePort (for local access):
   kubectl -n argocd edit service argocd-server  # Change type to NodePort
   ```

   **Method 2: Terraform (For more complex setups):**

   ```bash
   cd terraform
   terraform init
   terraform plan  # Review the plan
   terraform apply --auto-approve
   cd ..
   ```

4. **Access the Argo CD UI:**

   * **If using NodePort:** Get the NodePort: `kubectl get svc argocd-server -n argocd -o yaml | grep nodePort` and access via `http://<node_ip>:<node_port>`.
   * **If using port-forwarding:**
     ```bash
     kubectl port-forward -n argocd --address 0.0.0.0 svc/argocd-server 8080:8080
     ```
     Access the Argo CD UI at `http://localhost:8080`.
   * Get the initial admin password:
     ```bash
     argocd admin initial-password -n argocd
     ```
   * Log in with the `admin` username and the retrieved password.

5. **Install Argo CD Image Updater:**
   ```bash
   kubectl apply -n argocd -f [https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml](https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml)
   ```

6. **Create Argo CD Application:**
   * **Important:** Before applying the `app.yaml`, make sure the image name in `nginx/values.yaml` and `app.yaml` matches the image you pushed to Docker Hub (e.g., `lmen776/nginx-demo1:v1.0`).
   * Apply the `app.yaml` manifest. This creates the Argo CD Application, which will synchronize your Git repository with your Kubernetes cluster.
     ```bash
     kubectl apply -f app.yaml
     ```

## Automated Image Updates

The `app.yaml` file includes annotations that configure Argo CD Image Updater to automatically update the Nginx image whenever a new version is pushed to Docker Hub. The following annotations are used:

* `argocd-image-updater.argoproj.io/image-list`: Specifies the image to be updated (e.g., `nginx-demo1`).
* `argocd-image-updater.argoproj.io/nginx-demo1.update-strategy`: Sets the update strategy (e.g., `latest`).

## Updating the Nginx Image

1. **Build and push a new Nginx image (e.g., v1.1):**
   ```bash
   docker build -t lmen776/nginx-demo1:v1.1 .
   docker push lmen776/nginx-demo1:v1.1
   ```

2. **Argo CD Image Updater will automatically detect the new image tag (v1.1) and update the Nginx deployment.**  You'll see the change reflected in the Argo CD UI.

## Key improvements in this version:

* **Two Argo CD Installation Methods:** Includes both `kubectl apply` and Terraform options.
* **NodePort Explanation:** Adds clarity on using NodePort for local access.
* **Password Retrieval:** Uses `argocd admin initial-password` for password retrieval.
* **Clearer Image Update Process:**  Simplifies the steps for updating the Nginx image.
* **Values.yaml Importance:** Highlights the need to configure the image name in `values.yaml`.


