pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
    stage('build') {
      steps {
        sh 'build.sh'
      }
    }
  }
}
