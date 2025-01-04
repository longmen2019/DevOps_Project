# AWS EKS Setup and Deployment

This README provides a step-by-step guide to set up AWS EKS (Elastic Kubernetes Service) and deploy applications using `kubectl`, `aws-cli`, and `eksctl`. **Note**: This README is a supplement to the original `README.md`. I discovered methods to launch EKS from AWS CLI on EC2, making project implementation more seamless. For further reference, please follow this YouTube video: https://www.youtube.com/watch?v=SRHvKBYAwtQ

## Prerequisites

- AWS Account
- IAM user with necessary permissions
- EC2 instance with Amazon Linux 2

## Installation Steps

### Install kubectl

1. Download kubectl:
    ```bash
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.11/2023-03-17/bin/linux/amd64/kubectl
    ```

2. Make kubectl executable:
    ```bash
    chmod +x ./kubectl
    ```

3. Move kubectl to `/usr/local/bin`:
    ```bash
    sudo cp ./kubectl /usr/local/bin
    ```

4. Update PATH environment variable:
    ```bash
    export PATH=/usr/local/bin:$PATH
    ```

5. Verify kubectl installation:
    ```bash
    kubectl version --client
    ```

### Install AWS CLI

1. Download the AWS CLI:
    ```bash
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    ```

2. Unzip the downloaded file:
    ```bash
    unzip awscliv2.zip
    ```

3. Run the install script:
    ```bash
    sudo ./aws/install
    ```

4. Configure AWS CLI:
    ```bash
    aws configure
    ```

### Install eksctl

1. Download and extract eksctl:
    ```bash
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
    ```

2. Move eksctl to `/usr/local/bin`:
    ```bash
    sudo mv /tmp/eksctl /usr/local/bin
    ```

3. Verify eksctl installation:
    ```bash
    eksctl version
    ```

## EKS Cluster Setup

1. Create an EKS cluster without a node group:
    ```bash
    eksctl create cluster --name EKS-cluster --region us-east-1 --zones us-east-1a,us-east-1b,us-east-1c --without-nodegroup
    ```

2. Update kubeconfig for the cluster:
    ```bash
    aws eks update-kubeconfig --name EKS-cluster --region us-east-1
    ```

3. Verify the nodes:
    ```bash
    kubectl get nodes
    ```

## Deploy Applications

### Clone the Repository

1. Clone the repository:
    ```bash
    git clone https://github.com/longmen2019/aws-eks-RGM.git
    ```

2. Navigate to the `manifests` directory:
    ```bash
    cd aws-eks-RGM/manifests
    ```

### Create Namespace

1. Create a new namespace:
    ```bash
    kubectl create namespace nepaltech
    ```

2. Set the context to the new namespace:
    ```bash
    kubectl config set-context --current --namespace nepaltech
    ```

## MongoDB Setup

### MongoDB Database Setup

1. Apply MongoDB StatefulSet and Service:
    ```bash
    kubectl apply -f mongo-statefulset.yaml
    kubectl apply -f mongo-service.yaml
    ```

2. Verify the MongoDB pods and services:
    ```bash
    kubectl get all
    ```

### Initialize MongoDB Replica Set

1. Enter the mongo-0 pod:
    ```bash
    kubectl exec -it mongo-0 -- mongo
    ```

2. Run the following commands to initialize the replica set:
    ```js
    rs.initiate();
    sleep(2000);
    rs.add("mongo-1.mongo:27017");
    sleep(2000);
    rs.add("mongo-2.mongo:27017");
    sleep(2000);
    cfg = rs.conf();
    cfg.members[0].host = "mongo-0.mongo:27017";
    rs.reconfig(cfg, {force: true});
    sleep(5000);
    ```

3. Check if the replica set is implemented:
    ```bash
    kubectl exec -it mongo-0 -- mongo --eval "rs.status()" | grep "PRIMARY\|SECONDARY"
    ```

### Load Data into MongoDB

1. Enter the mongo-0 pod:
    ```bash
    kubectl exec -it mongo-0 -- mongo
    ```

2. Use the `langdb` database:
    ```js
    use langdb;
    ```

3. Insert data into the database:
    ```js
    db.languages.insert({"name" : "csharp", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 5, "compiled" : false, "homepage" : "https://dotnet.microsoft.com/learn/csharp", "download" : "https://dotnet.microsoft.com/download/", "votes" : 0}});
    db.languages.insert({"name" : "python", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 3, "script" : false, "homepage" : "https://www.python.org/", "download" : "https://www.python.org/downloads/", "votes" : 0}});
    db.languages.insert({"name" : "javascript", "codedetail" : { "usecase" : "web, client-side", "rank" : 7, "script" : false, "homepage" : "https://en.wikipedia.org/wiki/JavaScript", "download" : "n/a", "votes" : 0}});
    db.languages.insert({"name" : "go", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 12, "compiled" : true, "homepage" : "https://golang.org", "download" : "https://golang.org/dl/", "votes" : 0}});
    db.languages.insert({"name" : "java", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 1, "compiled" : true, "homepage" : "https://www.java.com/en/", "download" : "https://www.java.com/en/download/", "votes" : 0}});
    db.languages.insert({"name" : "nodejs", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 20, "script" : false, "homepage" : "https://nodejs.org/en/", "download" : "https://nodejs.org/en/download/", "votes" : 0}});
    ```

4. Create Mongo secret:
    ```bash
    kubectl apply -f mongo-secret.yaml
    ```

## API Setup

1. Create API deployment:
    ```bash
    kubectl apply -f api-deployment.yaml
    ```

2. Expose the deployment through a service:
    ```bash
    kubectl expose deployment api --name=api --type=LoadBalancer --port=80 --target-port=8080
    ```

3. Set the service endpoint over an environment variable:
    ```bash
    API_ELB_PUBLIC_FQDN=$(kubectl get svc api -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    until nslookup $API_ELB_PUBLIC_FQDN >/dev/null 2>&1; do sleep 2 && echo waiting for DNS to propagate...; done
    curl $API_ELB_PUBLIC_FQDN/ok
    echo
    ```

4. Test and confirm that the API endpoints can be called successfully:
    ```bash
    curl -s $API_ELB_PUBLIC_FQDN/languages | jq .
    ```

## Frontend Setup

1. Create the Frontend Deployment resource:
    ```bash
    kubectl apply -f frontend-deployment.yaml
    ```

2. Create a new Service resource of LoadBalancer type:
    ```bash
    kubectl expose deployment frontend --name=frontend --type=LoadBalancer --port=80 --target-port=8080
    ```

3. Confirm that the Frontend ELB is ready to receive HTTP traffic:
    ```bash
    FRONTEND_ELB_PUBLIC_FQDN=$(kubectl get svc frontend -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    until nslookup $FRONTEND_ELB_PUBLIC_FQDN >/dev/null 2>&1; do sleep 2 && echo waiting for DNS to propagate...; done
    curl -I $FRONTEND_ELB_PUBLIC_FQDN
    ```

4. Generate the Frontend URL for browsing:
    ```bash
    echo http://$FRONTEND_ELB_PUBLIC_FQDN
    ```

## Query MongoDB

1. Query the MongoDB database directly to observe the updated vote data:
    ```bash
    kubectl exec -it mongo-0 -- mongo langdb --eval "db.languages.find().pretty()"
    ```

## References

- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/latest[_{{{CITATION{{{_1{](https://github.com/shabi9/aks-demo/tree/f9551a5853a77d2aec150957ea2944fcb3c2a827/README.md)[_{{{CITATION{{{_2{](https://github.com/cloudacademy/voteapp-api-go/tree/6dffaa0e53382320cfa6697c70349a4e8a057ca4/README.md)[_{{{CITATION{{{_3{](https://github.com/ryanrdunn/voteapp-storage-network-compose-containers/tree/e00bc2ea479a40579e2be242ec7a3042430e6a26/README.md)[_{{{CITATION{{{_4{](https://github.com/abdevm/learning-cloud-computing/tree/e8cd420030b32c04fad70d5b43b9d0bc30242972/terraform-aws%2Fexercises%2Fexercise4%2Fmodules%2Fstorage%2Finstall.sh)