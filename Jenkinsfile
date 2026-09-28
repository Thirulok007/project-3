pipeline {
  agent any
  environment {
    DH_USER = 'thirulok2001'
  }
  stages {
    stage('Build') {
      steps {
        script {
          env.REPO = (env.BRANCH_NAME == 'master') ? 'prod' : 'dev'
        }
        sh "chmod +x build.sh deploy.sh"
        sh "./build.sh $DH_USER/$REPO $BUILD_NUMBER"
        sh "docker tag $DH_USER/$REPO:$BUILD_NUMBER $DH_USER/$REPO:latest"
      }
    }
    stage('Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'U', passwordVariable: 'P')]) {
          sh 'echo $P | docker login -u $U --password-stdin'
          sh "docker push $DH_USER/$REPO:$BUILD_NUMBER"
          sh "docker push $DH_USER/$REPO:latest"
        }
      }
    }
    stage('Deploy') {
      steps {
        sh "./deploy.sh $DH_USER/$REPO:latest"
      }
    }
  }
}