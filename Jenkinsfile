pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "findmyshow" // Replace 'your-dockerhub-username' with your Docker Hub username
    }

    stages {
        stage('SCM') {
            steps {
                checkout scm
            }
        }
         
        stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
        }

        stage('Build') {
            steps {
                script {
                    // Use a Dockerfile in the root of your repository
                    docker.build("${DOCKER_IMAGE_NAME}")

                    sh "docker images"
                }
            }
        }

        stage('Push') {
            steps {
                script {

                    // Retrieve Docker Hub credentials from Jenkins credentials store
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKERHUB_TOKEN', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        // Login to Docker Hub using the retrieved credentials
                        sh "${dockerPath}/docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_TOKEN} https://registry.hub.docker.com"

                        // Push the Docker image to Docker Hub
                        sh "${dockerPath}/docker push ${DOCKER_IMAGE_NAME}"

                        sh "${dockerPath}/docker images"
                    }
                }
            }
        }
   
    }
}


