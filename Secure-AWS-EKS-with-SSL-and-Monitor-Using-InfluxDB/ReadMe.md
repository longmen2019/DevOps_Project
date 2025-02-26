
```markdown
# CI/CD Pipeline for SSL-EKS and Two-Tier Flask App

This project utilizes Jenkins to automate the deployment and scanning of the SSL-EKS and Two-Tier Flask App. This pipeline performs various stages such as checking out the code, running Terraform scripts, SonarQube analysis, Snyk tests, Docker build and push, and deploying to Kubernetes.

## Pipeline Stages

### 1. Checkout from Git
This stage checks out the code from the specified Git repositories.

```groovy
stage('Checkout from Git') {
    steps {
        git branch: 'main', url: 'https://github.com/longmen2022/SSL-EKS.git'
    }
}
stage('Checkout from Git') {
    steps {
        git branch: 'master', url: 'https://github.com/Aj7Ay/two-tier-flask-app.git'
    }
}
```

### 2. Terraform
This section includes several Terraform-related stages:

- **Terraform Version**
    ```groovy
    stage('Terraform version') {
        steps {
            sh 'terraform --version'
        }
    }
    ```

- **Terraform Init**
    ```groovy
    stage('Terraform init') {
        steps {
            dir('Eks-terraform') {
                withCredentials([string(credentialsId: 'snyk', variable: 'snyk')]) {
                    sh 'snyk auth $snyk'
                    sh 'terraform init && snyk iac test --report || true'
                }
            }
        }
    }
    ```

- **Terraform Validate**
    ```groovy
    stage('Terraform validate') {
        steps {
            dir('Eks-terraform') {
                sh 'terraform validate'
            }
        }
    }
    ```

- **Terraform Plan**
    ```groovy
    stage('Terraform plan') {
        steps {
            dir('Eks-terraform') {
                sh 'terraform plan'
            }
        }
    }
    ```

- **Terraform Apply/Destroy**
    ```groovy
    stage('Terraform apply/destroy') {
        steps {
            dir('Eks-terraform') {
                script {
                    sh 'terraform ${action} --auto-approve'
                }
            }
        }
    }
    ```

### 3. SonarQube Analysis
This stage performs SonarQube analysis on the project.

```groovy
stage("Sonarqube Analysis") {
    steps {
        withSonarQubeEnv('sonar-server') {
            sh ''' 
            $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=flask \ 
            -Dsonar.projectKey=flask 
            '''
        }
    }
}
stage("quality gate") {
    steps {
        script {
            waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'
        }
    }
}
```

### 4. Security Scans
Various security scans are performed using Trivy and Snyk.

- **TRIVY FS Scan**
    ```groovy
    stage('TRIVY FS SCAN') {
        steps {
            sh "trivy fs . > trivyfs.json"
        }
    }
    ```

- **Snyk Tests**
    ```groovy
    stage('snyk test') {
        steps {
            withCredentials([string(credentialsId: 'snyk', variable: 'snyk')]) {
                sh 'snyk auth $snyk'
                sh 'snyk test --all-projects --report || true'
                sh 'snyk code test --json-file-output=vuln1.json || true'
            }
        }
    }
    ```

### 5. Docker Build & Push
This stage builds and pushes the Docker image.

```groovy
stage("Docker Build & Push") {
    steps {
        script {
            withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                sh "docker build -t flask2 ."
                sh "docker tag flask2 lmen776/flask2:latest"
                sh "docker push lmen776/flask2:latest"
            }
        }
    }
}
```

### 6. Snyk Image Scan
This stage performs an image scan using Snyk.

```groovy
stage('snyk image scan') {
    steps {
        withCredentials([string(credentialsId: 'snyk', variable: 'snyk')]) {
            sh 'snyk auth $snyk'
            sh 'snyk container test lmen776/flask2:latest --report || true'
        }
    }
}
```

### 7. Deploy to Kubernetes
This stage deploys the application to Kubernetes.

```groovy
stage('Deploy to kubernets') {
    steps {
        script {
            dir('eks-manifests') {
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                    sh 'kubectl apply -f mysql-secrets.yml -f mysql-configmap.yml -f mysql-deployment.yml -f mysql-svc.yml'
                    sh 'sleep 30'
                    sh 'kubectl apply -f two-tier-app-deployment.yml -f two-tier-app-svc.yml'
                }
            }
        }
    }
}
```

## Post Actions
This section includes post-build actions such as sending email notifications.

```groovy
post {
    always {
        script {
            def jobName = env.JOB_NAME
            def buildNumber = env.BUILD_NUMBER
            def pipelineStatus = currentBuild.result ?: 'UNKNOWN'
            def bannerColor = (pipelineStatus.toUpperCase() == 'SUCCESS') ? 'green' : (pipelineStatus.toUpperCase() == 'ABORTED') ? 'orange' : 'red'
            def body = """
            <html>
            <body>
            <div style="border: 4px solid ${bannerColor}; padding: 10px;">
            <h2>${jobName} - Build ${buildNumber}</h2>
            <div style="background-color: ${bannerColor}; padding: 10px;">
            <h3 style="color: white;">Pipeline Status: ${pipelineStatus.toUpperCase()}</h3>
            </div>
            <p>Check the <a href="${BUILD_URL}">console output</a>.</p>
            </div>
            </body>
            </html>
            """
            emailext ( subject: "${jobName} - Build ${buildNumber} - ${pipelineStatus.toUpperCase()}",
                       body: body,
                       to: 'lmen776@gmail.com',
                       from: 'lmen776@gmail.com',
                       replyTo: 'lmen776@gmail.com',
                       mimeType: 'text/html',
                       attachmentsPattern: 'trivy-report.html'
                     )
        }
    }
}
```

## Notes
- **Credentials**: Modify the directory and credential details according to your environment.
- **Detailed Instructions**: Refer to [Mr. Cloud's detailed instructions](https://mrcloudbook.com/secure-aws-eks-with-ssl-and-monitor-using-influxdb-in-devsecops-project/) for more information on setting up the pipeline.
```


