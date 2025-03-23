# **Jenkins Installation and Setup on Ubuntu/Debian & RedHat/CentOS**

A comprehensive guide to installing Jenkins, configuring AWS CLI, and setting up a Kubernetes cluster using `eksctl`.

## **Table of Contents**
- [Ubuntu/Debian Installation](#ubuntudebian-installation)
- [RedHat/CentOS Installation](#redhatcentos-installation)
- [Jenkins Configuration](#jenkins-configuration)
- [AWS CLI Configuration](#aws-cli-configuration)
- [Kubernetes Cluster Setup with eksctl](#kubernetes-cluster-setup-with-eksctl)
- [Additional Commands](#additional-commands)

---

## **Ubuntu/Debian Installation**

### **1. Update Your System**
```bash
sudo apt update
```

### **2. Install Java (OpenJDK 17)**
```bash
sudo apt install fontconfig openjdk-17-jre
java -version  # Verify installation
```

### **3. Add Jenkins Repository and Install**
```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

### **4. Enable and Start Jenkins Service**
```bash
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins  # Verify service is running
```

---

## **RedHat/CentOS Installation**

### **1. Update Your System**
```bash
sudo dnf upgrade
```

### **2. Add Jenkins Repository and Install**
```bash
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install fontconfig java-17-openjdk jenkins
```

### **3. Enable and Start Jenkins Service**
```bash
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins  # Verify service is running
```

---

## **Jenkins Configuration**

1. **Access Jenkins Web Interface**:
   - Navigate to `http://your-server-ip:8080` in your web browser.

2. **Follow the On-Screen Instructions**:
   - Retrieve the initial admin password from `/var/lib/jenkins/secrets/initialAdminPassword`.
   - Install suggested plugins or customize your setup.
   - Create an administrator user.

---

## **AWS CLI Configuration**

### **1. Install Unzip (if Required)**
```bash
sudo apt install unzip  # For Ubuntu/Debian
sudo dnf install unzip  # For RedHat/CentOS
```

### **2. Download and Install AWS CLI v2**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
aws --version  # Verify installation
```

### **3. Configure AWS Credentials**
```bash
aws configure
```
Provide:
- AWS Access Key ID
- Secret Access Key
- Default region
- Output format

---

## **Kubernetes Cluster Setup with eksctl**

### **1. Install eksctl**
```bash
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
eksctl version  # Verify installation
```

### **2. Create an EKS Cluster**
```bash
eksctl create cluster --name <cluster-name> --region <aws-region> --nodegroup-name <nodegroup-name> --node-type <instance-type> --managed --nodes <number-of-nodes>
```

---

## **Additional Commands**

### **Docker**
```bash
docker images  # List Docker images
sudo usermod -aG docker $USER  # Add user to Docker group
newgrp docker  # Apply group changes
```

### **Firewall (RedHat/CentOS)**
```bash
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"
firewall-cmd $PERM --new-service=jenkins
firewall-cmd $SERV --set-short="Jenkins ports"
firewall-cmd $SERV --set-description="Jenkins port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=jenkins
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
```

### **Helm (Kubernetes Package Manager)**
```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes  # For Ubuntu/Debian
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
helm version  # Verify installation
```

### **Kubectl (Kubernetes Command-Line Tool)**
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo "$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"  kubectl | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client  # Verify installation
```

---

**Note:** Replace placeholders (e.g., `<cluster-name>`, `<aws-region>`, etc.) with actual values.

