pipeline {
    agent any 

    environment {
        SONAR_SERVER = 'SonarQube' 
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm 
            }
        }

        stage('SonarQube Code Analysis') {
            steps {
                withSonarQubeEnv(SONAR_SERVER) {
                    sh "$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=omkar-portfolio -Dsonar.sources=."
                }
            }
        }

        stage('Quality Gate') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    timeout(time: 1, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Jenkins reads your Dockerfile and builds the immutable image
                sh 'docker build -t omkar-portfolio:latest .'
            }
        }

        stage('Deploy via Terraform') {
            steps {
                // Initialize Terraform to download the Docker provider
                sh 'terraform init'
                // Apply the main.tf configuration automatically
                sh 'terraform apply -auto-approve'
                echo "Container deployed! Check http://172.18.95.222:8081"
            }
        }
    }
}
