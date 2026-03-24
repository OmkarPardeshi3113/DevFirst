pipeline {
    agent any 

    environment {
        SONAR_SERVER = 'SonarQube' 
        // We bypass the tools block and dynamically grab the installation path here
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
                    // We call the executable directly using the absolute path
                    sh '''
                    $SCANNER_HOME/bin/sonar-scanner \
                      -Dsonar.projectKey=omkar-portfolio \
                      -Dsonar.projectName="Omkar Portfolio Website" \
                      -Dsonar.sources=.
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Deploy to Local Nginx') {
            steps {
                sh 'cp index.html /var/www/html/index.html'
            }
        }
    }
}
