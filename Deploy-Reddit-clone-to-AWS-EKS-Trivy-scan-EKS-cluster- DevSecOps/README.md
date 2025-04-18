

# Reddit Clone App on Kubernetes with Ingress  
This project demonstrates how to deploy a Reddit clone app on Kubernetes using Ingress to expose it to the world. Minikube is used as the cluster for this setup.  

## Prerequisites  
Before you begin, make sure the following tools are installed on your local machine:  

- 🐳 **Docker**  
- 🤖 **Kubeadm master and worker node**  
- 🛠️ **kubectl**  
- 📂 **Git**  

You can install these prerequisites step-by-step by following [this guide](#).  

## Installation  
Follow these steps to install and run the Reddit clone app on your local machine:  

1. Clone this repository to your local machine:  
   ```bash
   git clone https://github.com/LondheShubham153/reddit-clone-k8s-ingress.git
   ```  
2. Navigate to the project directory:  
   ```bash
   cd reddit-clone-k8s-ingress
   ```  
3. Build the Docker image for the Reddit clone app:  
   ```bash
   docker build -t reddit-clone-app .
   ```  
4. Deploy the app to Kubernetes:  
   ```bash
   kubectl apply -f deployment.yaml
   ```  
5. Deploy the service for the deployment to Kubernetes:  
   ```bash
   kubectl apply -f service.yaml
   ```  
6. Enable Ingress by running this command:  
   ```bash
   minikube addons enable ingress
   ```  
7. Expose the app as a Kubernetes service:  
   ```bash
   kubectl expose deployment reddit-deployment --type=NodePort --port=5000
   ```  
8. Create an Ingress resource:  
   ```bash
   kubectl apply -f ingress.yaml
   ```  

## Test Ingress DNS for the App  
After deploying the Ingress resource, you can test the DNS for the app using tools like `curl`, your browser, or other DNS testing tools.  

## Contributing  
If you'd like to contribute to this project, please open an issue or submit a pull request.  
