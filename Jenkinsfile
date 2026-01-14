pipeline {
    agent { label 'Jenkins-Agent' }

    environment {
        APP_NAME = "flask-app"
        VENV = "venv"
        SCANNER_HOME = tool 'sonarqube-scanner'
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
                    credentialsId: 'github',
                    url: 'https://github.com/sangnt8386/jenkins-pipeline-demo.git'
            }
        }

        stage("Setup Python Env") {
    steps {
        sh """
        python3.9 -m venv venv
        . venv/bin/activate
        pip install -r requirements.txt
        """
    }
}

        stage("Run Tests") {
            steps {
                sh '''
                . ${VENV}/bin/activate
                pytest || true
                '''
            }
        }
        
        stage("Run Flask App (Test)") {
            steps {
                sh '''
                . ${VENV}/bin/activate
                export FLASK_APP=app.py
                flask run --host=0.0.0.0 --port=5000 &
                sleep 5
                '''
            }
        }
        stage("SonarQube Analysis") {
    steps {
        script {
            withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
                sh """
                ${SCANNER_HOME}/bin/sonar-scanner \
                -Dsonar.projectKey=flask-app \
                -Dsonar.sources=. \
                -Dsonar.exclusions=venv/**,**/*.spec,tests/** \
                -Dsonar.language=py \
                -Dsonar.python.version=3.9
                """
            }
        }
    }
}
    }
}
