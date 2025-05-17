pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'jen-git-dind', url: 'https://github.com/longmen2022/complete_cicd_2.git'
            }
        }
    }
}
