pipeline {
    agent any

    tools {
        jdk 'JDK'
    }

    environment {
        SCANNER_HOME = tool 'SonarQube Scanner'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/longmen2022/End_to_End_Book_Recommender_System.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh """
                        ${SCANNER_HOME}/bin/sonar-scanner \\
                        -Dsonar.projectName=end_to_end_book_recommender_system \\
                        -Dsonar.projectKey=end_to_end_book_recommender_system
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
            }
        }

        stage('Trivy Scan') {
            steps {
                sh 'trivy fs . > trivy.txt'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker build -t book-recommender .'
                        sh 'docker tag book-recommender lmen776/book-recommender:latest'
                        sh 'docker push lmen776/book-recommender:latest'
                    }
                }
            }
        }

        stage('Clean Up Existing Container') {
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

        stage('Deploy to Kubernetes') {
            steps {
                dir('k8s_files') {
                    sh '''
                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml
                        kubectl apply -f ingress.yaml
                    '''
                }
            }
        }
    }
}
