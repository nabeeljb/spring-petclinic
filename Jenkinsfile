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

        stage('SonarCloud') {
            steps {
                echo "============================="
                echo "Scanning code with SonarCloud"
                echo "============================="
                withSonarQubeEnv('sonarserver1') {
                    sh "mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -D sonar.projectKey=nabeeljb_spring-petclinic"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
