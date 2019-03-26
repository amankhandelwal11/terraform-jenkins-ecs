pipeline {
    agent { label 'ecs' }
    stages {

        stage(CheckoutSCM) {

            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/jenkins-docs/simple-java-maven-app.git']]])
            }
        }

        stage('Build') {

          steps {
            sh 'mvn -B -DskipTests clean package'
          }
        }

        stage('Test') {

          steps {
            sh 'mvn test'
          }
        }
    }
}
