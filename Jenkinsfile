pipeline {
    agent { label 'Jenkins-Agent' }

    environment {
        APP_NAME = "flask-app-pipeline"
        VENV = "venv"
    }

    stages {

        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout Code") {
            steps {
                git branch: 'main',
                    credentialsId: 'sangnt8386',
                    url: 'https://github.com/sangnt8386/jenkins-pipeline-demo.git'
            }
        }

        stage("Setup Python Environment") {
            steps {
                sh '''
                python3 --version
                python3 -m venv ${VENV}
                . ${VENV}/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage("Run Tests") {
            steps {
                sh '''
                . ${VENV}/bin/activate
                pytest
                '''
            }
        }
		stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh '''
                    sonar-scanner \
                      -Dsonar.projectKey=flask-app-pipeline \
                      -Dsonar.sources=. \
                      -Dsonar.language=py \
                      -Dsonar.python.version=3
                    '''
                }
            }
        }
    }
}
