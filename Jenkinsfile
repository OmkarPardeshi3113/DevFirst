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
                // We wrap this so a timeout doesn't kill the whole build
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    timeout(time: 1, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }

        stage('Deploy to Local Nginx') {
            steps {
                // Force copy to the web directory
                sh 'cp index.html /var/www/html/index.html'
                echo "Deployment complete! check http://172.18.95.222"
            }
        }
    }
}
