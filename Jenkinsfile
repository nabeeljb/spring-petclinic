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
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Creating AMI and Pushing to Artifactory') {
            steps {
                dir('/var/jenkins_home/workspace/clinic') {
                    sh 'cp /var/jenkins_home/workspace/clinic/target/spring-petclinic-3.1.0-SNAPSHOT.jar /var/jenkins_home/workspace/clinic/'
                    sh 'docker build -t alak .'
                    withCredentials([usernamePassword(credentialsId: 'JFROG_CRED', usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                        sh 'docker login https://nabeeljb.jfrog.io -u $ARTIFACTORY_USER -p $ARTIFACTORY_PASSWORD'
                        sh 'docker tag alak:latest nabeeljb.jfrog.io/petclinic-docker-local/alak:latest'
                        sh 'docker push nabeeljb.jfrog.io/petclinic-docker-local/alak:latest'
                        sh 'docker logout' // Adding this step to log out from Docker registry
                    }
                }
            }
        }
    }

    post {
        failure {
            sh 'docker rmi $(docker images)'
            sh 'docker rm $(docker ps -aq)'
            cleanWs()
        }
        success {
            archiveArtifacts(artifacts: '**/*.jar', fingerprint: true)
        }
    }
}
