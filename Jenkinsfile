pipeline {
    agent any 

    tools {
        // This MUST match the exact name we gave the scanner in Jenkins > Tools
        sonarScanner 'sonar-scanner' 
    }

    environment {
        // This MUST match the exact name we gave the server in Jenkins > System
        SONAR_SERVER = 'SonarQube' 
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Jenkins automatically pulls the latest code from the Git branch triggering the build
                checkout scm 
            }
        }

        stage('SonarQube Code Analysis') {
            steps {
                // This wrapper injects the authentication token we saved earlier
                withSonarQubeEnv(SONAR_SERVER) {
                    // Execute the scanner and define the project details dynamically
                    sh '''
                    sonar-scanner \
                      -Dsonar.projectKey=omkar-portfolio \
                      -Dsonar.projectName="Omkar Portfolio Website" \
                      -Dsonar.sources=.
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                // The pipeline pauses here and waits for SonarQube to reply "Passed" or "Failed"
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Deploy to Local Nginx') {
            steps {
                // Copy the validated HTML file directly to the local web server directory
                sh 'cp index.html /var/www/html/index.html'
            }
        }
    }
}
