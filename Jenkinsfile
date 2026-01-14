pipeline {
    agent { label 'Jenkins-Agent' }

    environment {
        APP_NAME = "flask-app-pipeline"
        VENV = "venv"
        SCANNER_HOME = tool 'sonarqube-scanner'
        RELEASE = "1.0.0"
        DOCKER_USER = "sangnt8386"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	    
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
            // Đảm bảo credentialsId khớp với ID bạn đặt trong Jenkins (sonarqube-sever hoặc jenkins-sonarqube-token)
            withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') { 
                sh """
                ${SCANNER_HOME}/bin/sonar-scanner \
                -Dsonar.projectKey=flask-app \
                -Dsonar.sources=. \
                -Dsonar.language=py \
                -Dsonar.python.version=3.9 \
                -Dsonar.exclusions=venv/**,tests/**,**/*.html,**/*.css,**/*.js
                """
            }
        }
    }
}
        stage("Quality Gate"){
           steps {
               script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube-token'
                }	
            }

        }
	    stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
		}
    }
}
