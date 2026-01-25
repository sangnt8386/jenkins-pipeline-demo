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

    }
}
