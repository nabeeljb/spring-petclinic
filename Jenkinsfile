pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/nabeeljb/spring-petclinic.git'
            }
        }

        stage('SonarCloud Analysis') {
            steps {
                withSonarQubeEnv('sonarserver1') {
                    withCredentials([string(credentialsId: 'sonar_tkn', variable: 'SONAR_TOKEN')]) {
                        sh 'mvn clean compile sonar:sonar -Dsonar.projectKey=nabeeljb_spring-petclinic -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.login=$SONAR_TOKEN -Dsonar.java.binaries=target/classes'
                    }
                }
            }
        }

        stage('Build and Package') {
            steps {
                sh 'mvn clean package'
            }
        }
    }

    post { 
        failure { cleanWs() }
        success {
            archiveArtifacts(artifacts: '**/*.jar', fingerprint: true)
        }
    }
}
