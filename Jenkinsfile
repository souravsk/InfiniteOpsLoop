pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "sovu/findmyshow" // Replace 'your-dockerhub-username' with your Docker Hub username
    }

    stages {
        stage('SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Use a Dockerfile in the root of your repository
                    docker.build("${DOCKER_IMAGE_NAME}")
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    // Login to Docker Hub using the provided Docker Hub credentials
                    docker.withRegistry('https://registry.hub.docker.com', "${DOCKER_HUB_CREDS_ID}") {
                        // Push the Docker image to Docker Hub
                        docker.image("${DOCKER_IMAGE_NAME}").push()
                    }
                }
            }
        }
    }
}