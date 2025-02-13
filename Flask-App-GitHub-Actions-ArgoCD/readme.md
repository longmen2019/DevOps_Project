# DevOps Project

This project sets up a Flask application using GitHub Actions and Argo CD. Follow the steps below to get started.

## Clone the Repository

```sh
git clone https://github.com/longmen2019/DevOps_Project.git
cd DevOps_Project/Flask-App-GitHub-Actions-ArgoCD
```

## Install Dependencies

```sh
pip install -r requirements.txt
```

## Setup Docker

Remove any previous Docker installations and install Docker:

```sh
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
exec su -l $USER
```

## Build and Run the Docker Image

```sh
docker build -t demo-app:v1 .
docker run -d -p 8080:5000 --name demo-app demo-app:v1
```

## Setup Minikube

Download and install Minikube:

```sh
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube start
```

## Install Argo CD

Create the namespace and install Argo CD:

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify the installation:

```sh
kubectl get all -n argocd
```

## Access Argo CD

Patch the Argo CD server to use NodePort:

```sh
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl get svc -n argocd
```

Retrieve the Argo CD initial admin password:

```sh
kubectl get secrets -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```

Access the Argo CD server using the Minikube IP and NodePort:

```sh
minikube service argocd-server -n argocd
```

Example output:

```sh
|-----------|---------------|-------------|---------------------------|
| NAMESPACE |     NAME      | TARGET PORT |            URL            |
|-----------|---------------|-------------|---------------------------|
| argocd    | argocd-server | http/80     | http://192.168.49.2:30740 |
|           |               | https/443   | http://192.168.49.2:31223 |
|-----------|---------------|-------------|---------------------------|
```

## Cleanup

To delete Argo CD and related resources:

```sh
kubectl delete namespace argocd
kubectl delete crd applications.argoproj.io
kubectl delete crd appprojects.argoproj.io
kubectl delete all --all -n argocd
```

## Switch to LoadBalancer

If you prefer to use a LoadBalancer instead of NodePort:

```sh
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc -n argocd argocd-server
```

