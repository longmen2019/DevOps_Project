```markdown
# 📚 End-to-End Book Recommender System

An interactive, AI-powered book recommendation platform built with **Streamlit**, backed by a production-grade **CI/CD pipeline**, and containerized with **Docker** for smooth deployment to **Kubernetes**. It follows DevSecOps best practices with tools like **SonarQube**, **Trivy**, and **Terraform**.

---

## 🗂️ Project Structure

```
End-to-End-Book-Recommender-System/
├── config.yaml
├── entity/
├── config/
│   └── configuration.py
├── components/
├── pipeline/
├── main.py
├── app.py
├── k8s_files/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
└── requirements.txt
```

---

## ⚙️ Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/longmen2022/End-to-End-Book-Recommender-System.git
cd End-to-End-Book-Recommender-System
```

### 2️⃣ Setup Conda Environment

```bash
conda create -n books python=3.7.10 -y
conda activate books
pip install -r requirements.txt
```

### 3️⃣ Run Streamlit App (Locally)

```bash
streamlit run app.py
```

App runs at [http://localhost:8501](http://localhost:8501)

---

## 🐳 Docker

### Build, Tag & Push

```bash
docker build -t book-recommender .
docker tag book-recommender lmen776/book-recommender:latest
docker push lmen776/book-recommender:latest
```

### Run Locally in Container

```bash
docker run -d --name book-recommender -p 8501:8501 lmen776/book-recommender:latest
```

---

## ☸️ Kubernetes Deployment

Make sure you're in the `k8s_files/` directory and connected to your cluster.

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

Access the app via LoadBalancer IP or Ingress host depending on your configuration.

---

## 🔐 DevSecOps Workflow

### CI/CD Pipeline (Jenkins)

1. **Checkout Code**  
2. **SonarQube Analysis**  
3. **Quality Gate**  
4. **Trivy Scan**  
5. **Docker Build & Push**  
6. **Deploy to Container**  
7. **Deploy to Kubernetes**

All stages are defined in a `Jenkinsfile` leveraging `withDockerRegistry`, `waitForQualityGate`, and `kubectl apply`.

### Sample Cleanup + Deploy Stage

```groovy
stage('Clean Up Container') {
    steps {
        sh '''
            docker ps -q --filter "name=book-recommender" | grep -q . && docker rm -f book-recommender || true
        '''
    }
}
stage('Deploy to Container') {
    steps {
        sh 'docker run -d --name book-recommender -p 8501:8501 lmen776/book-recommender:latest'
    }
}
```

---

## 🔎 Security: Scanning & Validation

- ✅ **SonarQube**: Ensures code quality + coverage thresholds
- ✅ **Trivy**: Scans filesystem or Docker images for vulnerabilities
- ✅ **Terraform + Jenkins**: For provisioning secure, reproducible infrastructure

---

## 📦 Terraform (Optional Infra Provisioning)

```bash
terraform init
terraform plan -out=tfplan
terraform apply -auto-approve tfplan
```

---

## 🤝 Contributing

Pull requests welcome! Whether it’s polishing the UI, improving ML logic, or extending pipeline automation—contributions make this even better.

---

## 👤 Maintained By

**longmen2022**

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.
```
