pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/nabeeljb/spring-petclinic.git'
            }
        }

        stage('Build and Compile') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
                sh 'mvn package'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
