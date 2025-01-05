
# 3Tier Robot Shop Deployment

This guide provides step-by-step instructions on how to deploy the 3Tier Robot Shop project using Amazon EKS, Helm, and various Kubernetes resources.

## Prerequisites

- AWS CLI v2
- eksctl
- kubectl
- Helm v3
- An AWS account with necessary permissions

## Step-by-Step Deployment

### 1. Update and Upgrade the System
```bash
sudo apt update
sudo apt upgrade
sudo do-release-upgrade
sudo reboot
sudo hostname 3tier
/bin/bash
```

### 2. Install kubectl
```bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.6/2024-11-15/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.6/2024-11-15/bin/linux/amd64/kubectl.sha256
sha256sum -c kubectl.sha256
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version
```

### 3. Install eksctl
```bash
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

### 4. Install AWS CLI v2
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
aws --version
aws configure
aws sts get-caller-identity
```

### 5. Install Helm
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version
```

### 6. Clone the Repository
```bash
git clone https://github.com/Aj7Ay/3Tier-Robot-shop.git
cd 3Tier-Robot-shop
```

### 7. Create EKS Cluster
```bash
eksctl create cluster --name demo-cluster-three-tier-1 --region us-east-1 --without-nodegroup
export cluster_name=demo-cluster-three-tier-1
```

### 8. Associate IAM OIDC Provider
```bash
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

### 9. Create IAM Policy for AWS Load Balancer Controller
```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
```

### 10. Create IAM Service Account for AWS Load Balancer Controller
```bash
eksctl create iamserviceaccount --cluster $cluster_name --namespace kube-system --name aws-load-balancer-controller --attach-policy-arn arn:aws:iam::471112503258:policy/AWSLoadBalancerControllerIAMPolicy --approve
```

### 11. Install AWS Load Balancer Controller
```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=demo-cluster-three-tier-1 --set serviceAccount.create=false --set region=us-east-1 --set vpcId=vpc-0c8210fd4c1668745 --set serviceAccount.name=aws-load-balancer-controller
kubectl get deployment -n kube-system aws-load-balancer-controller
```

### 12. Create IAM Service Account for EBS CSI Driver
```bash
eksctl create iamserviceaccount --name ebs-csi-controller-sa --namespace kube-system --cluster demo-cluster-three-tier-1 --role-name AmazonEKS_EBS_CSI_DriverRole --role-only --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy --approve
```

### 13. Create EBS CSI Driver Addon
```bash
eksctl create addon --name aws-ebs-csi-driver --cluster demo-cluster-three-tier-1 --service-account-role-arn arn:aws:iam::471112503258:role/AmazonEKS_EBS_CSI_DriverRole --force
```

### 14. Deploy Robot Shop Application
```bash
kubectl create ns robot-shop
cd /path/to/your/helm/chart
helm install robot-shop --namespace robot-shop .
```

### 15. Apply Ingress Configuration
```bash
kubectl apply -f ingress.yaml
kubectl get ingress -A
kubectl describe ingress <ingress-name> -n <namespace>
```

### 16. Verify Deployment
```bash
kubectl get pods -n robot-shop
kubectl get svc -n robot-shop
kubectl describe pod <pod-name> -n robot-shop
kubectl logs <pod-name> -n robot-shop
kubectl top nodes
```

## Troubleshooting

### Common Issues
- Ensure IAM roles have the necessary permissions.
- Verify network connectivity between EKS cluster and AWS services.
- Check pod logs and events for errors.

