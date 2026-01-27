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
                pytest || true
                '''
            }
        }
		stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh '''
                    ${SCANNER_HOME}/bin/sonar-scanner \
                      -Dsonar.projectKey=flask-app-pipeline \
                      -Dsonar.sources=. \
                      -Dsonar.language=py \
                      -Dsonar.python.version=3
                    '''
                }
            }
        }
		stage("Quality Gate") {
    		steps {
        		script {
            		waitForQualityGate abortPipeline: true
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
		stage("Trivy Scan") {
           steps {
               script {
	            sh ('docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image sangnt8386/flask-app-pipeline:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table')
               }
           }
       }
         stage ('Cleanup Artifacts') {
           steps {
               script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
               }
          }
       }
}
}
