pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-cred')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/NomadNavigator/Sample-Application.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    def app = docker.build("devops-wizard-app:${env.BUILD_ID}")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image("devops-wizard-app:${env.BUILD_ID}").inside {
                        sh 'go test -v ./...'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        docker.image("devops-wizard-app:${env.BUILD_ID}").push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Use terraform to deploy the application
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
