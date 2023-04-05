
pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }
    stage('Docker Build') {
      steps {
        withEnv(['DOCKER_BUILDKIT=0']){
        sh 'echo $DOCKER_BUILDKIT'
        sh 'echo "$image_name":"$tag"'
        sh 'docker build . -t "$image_name":"$tag"'
        }
      }
    }
    stage('Push Docker Image'){
        steps{
            sh 'docker push "$image_name":"$tag"'
        }
    }
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }
        stage('Deploy') {
            steps {
                 echo 'Empty'
                }
            }
    }
}

