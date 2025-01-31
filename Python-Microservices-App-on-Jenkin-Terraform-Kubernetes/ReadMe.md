## Jenkins and Additional Terraform Setup

1. Navigate to the `jenkins-terraform` directory:
    ```bash
    cd jenkins-terraform
    ```

2. Edit the `backend.tf` file:
    ```bash
    nano backend.tf
    ```

3. Initialize and apply Terraform configuration:
    ```bash
    terraform init
    terraform apply -var-file="variables.tfvars"
    ```

4. Delete Jenkins IAM role:
    ```bash
    aws iam delete-role --role-name Jenkins-iam-role
    terraform apply -var-file="variables.tfvars"
    ```

5. Delete Jenkins instance profile:
    ```bash
    aws iam delete-instance-profile --instance-profile-name Jenkins-instance-profile
    terraform apply -var-file="variables.tfvars"
    ```

6. Navigate to the `eks-terraform` directory and initialize Terraform:
    ```bash
    cd eks-terraform
    terraform init
    terraform apply -var-file="variables.tfvars"
    ```

7. Update kubeconfig for EKS cluster:
    ```bash
    aws eks update-kubeconfig --name Tetris-EKS-Cluster --region us-east-1
    kubectl get nodes
    ```

8. Apply Terraform configurations:
    ```bash
    terraform apply --auto-approve
    kubectl get nodes
    aws eks update-kubeconfig --name microservices --region us-east-1
    kubectl get nodes
    kubectl get svc
    ```

9. Navigate to the Helm charts directory and install MongoDB:
    ```bash
    cd microservices-python-app/Helm_charts
    helm install mongo
    helm install MongoDB
    cd MongoDB
    helm install mongo .
    kubectl get ns
    kubectl get pods
    kubectl get pods -w
    kubectl get all
    kubectl get pv
    ```

10. Configure PostgreSQL:
    ```bash
    cd Postgres
    cat init.sql
    nano init.sql
    helm install postgres .
    ```

11. Apply Kubernetes manifests for notification-service:
    ```bash
    cd src/notification-service/manifest
    kubectl apply -f .
    nano secret.yaml
    ```

12. Install MongoDB and MongoSH:
    ```bash
    mongosh mongodb://nasi:1234@172-31-39-182:30005/mp3s?authSource=admin
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-mongosh
    ```

13. Verify MongoSH installation:
    ```bash
    mongosh --version
    ```

14. Install MongoDB 8.0 and MongoSH shared libraries:
    ```bash
    wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-8.0.asc
    sudo apt-get install gnupg
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-mongosh
    sudo apt-get install -y mongodb-mongosh-shared-openssl11
    sudo apt-get install -y mongodb-mongosh-shared-openssl3
    ```

15. Destroy Terraform infrastructure:
    ```bash
    cd terraform-eks
    terraform destroy --auto-approve
    ```

16. Initialize and apply Terraform configurations:
    ```bash
    terraform init
    terraform plan
    terraform apply --auto-approve
    terraform destroy --auto-approve
    ```

17. Initialize and format Terraform configurations:
    ```bash
    cd terraform-eks2
    terraform init
    terraform fmt
    terraform plan
    terraform apply --auto-approve
    ```

18. Initialize and upgrade Terraform configurations:
    ```bash
    terraform init -upgrade
    terraform plan
    terraform apply --auto-approve
    terraform destroy --auto-approve
    ```

Feel free to add these steps to your `README.md` file. If you need any further assistance or more details, just let me know! 😊
