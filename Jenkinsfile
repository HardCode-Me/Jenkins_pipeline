pipeline {
  agent {

    docker {
      image '130.193.41.165:8123/tomcat:v1'
      args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
    }
  }
   
  stages {
    stage ('git') {
      steps {
        git 'https://github.com/HardCode-Me/test_java_hello.git'
      }
    }
   
    
    stage('build'){
      steps {
        sh 'mvn package'
      }
    }
        
      
    stage ('push images') {
      steps {
         sh 'cd /var/lib/jenkins/workspace/test/target/ && cp hello-1.0.war /var/lib/jenkins/workspace/test'
         sh 'cd /var/lib/jenkins/workspace/test && docker build -t myweb2:v1 .'
         sh '''docker tag myweb2:v1 130.193.41.165:8123/myweb2:v001 && docker push 130.193.41.165:8123/myweb2:v1'''
      }
    }

    stage ('run boxfuse') {
      steps {
        sh 'ssh-keyscan 51.250.21.24 >> ~/.ssh/known_hosts'
        sh '''ssh root@51.250.21.24 /bin/bash << EOF
         docker pull 130.193.41.165:8123/myweb2:v1
         docker run -d -p 8085:8080 130.193.41.165:8123/myweb2:v1
EOF'''
      }
    }
  }
}
