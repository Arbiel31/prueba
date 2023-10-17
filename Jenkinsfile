pipeline {

  environment {
    dockerimagename = "arbiel/prueba"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
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
          bat "kubectl delete -n default deployment prueba"
          bat "kubectl create deployment prueba --image=arbiel/prueba:latest"
          bat "kubectl delete -n default service prueba"
          bat "kubectl expose deployment prueba --type=LoadBalancer --port=4200"
        }
      }
    }

  }

}