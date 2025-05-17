pipeline {
    agent any

    tools {
        nodejs 'NodeJS'
    }

    environment {
        SONAR_PROJECT_KEY = 'complete-cicd-02'
        SONAR_SCANNER_HOME = tool 'SonarQubeScanner'
        DOCKER_HUB_REPO = 'lmen776/complete-cicd-02'
        JOB_NAME_NOW = 'cicd02'
        ECR_REPO = 'longmenawsrepo'
        IMAGE_TAG = 'latest'
        ECR_REGISTRY = '471112503258.dkr.ecr.us-east-1.amazonaws.com'
    }

    stages {
        stage('GitHub') {
            steps {
                git branch: 'main', credentialsId: 'jen-git-dind', url: 'https://github.com/longmen2022/complete_cicd_2.git'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'complete-cicd-02', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('SonarQube') {
                        sh """
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://sonarqube-dind:9000 \
                        -Dsonar.login=${SONAR_TOKEN}
                        """
                    }
                }
            }
        }

        stage('Docker Image') {
            steps {
                script {
                    docker.build("${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}")
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                sh """
                trivy image --severity=HIGH,CRITICAL --no-progress --format=table \
                -o trivy-report.html ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}
                """
            }
        }

        stage('Login to ECR') {
            steps {
                sh """
                aws ecr get-login-password --region us-east-1 | \
                docker login --username AWS --password-stdin ${ECR_REGISTRY}
                """
            }
        }

        stage('Push Image to ECR') {
            steps {
                script {
                    docker.image("${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}").push()
                }
            }
        }
    }
}
