pipeline {

  environment {
    dockerimagename = "arbiel/prueba"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
        environment {
               registryCredential = 'github'
           }
      steps {
        git 'https://github.com/Arbiel31/prueba.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying React.js container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        }
      }
    }

  }

}