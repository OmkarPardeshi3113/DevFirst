pipeline {
    agent any

    environment {
        WEB_SERVER_IP = '54.210.1.215'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Pulling the latest code from GitHub...'
                checkout scm
            }
        }

        stage('Python QA Testing') {
            steps {
                echo 'Executing Python testing best practices...'
                sh 'python3 test_build.py'
            }
        }

        stage('Deploy with Docker') {
            steps {
                echo 'Deploying update securely via Docker container...'
                
                // Securely injects our SSH key from the Jenkins Vault
                sshagent(credentials: ['web-server-key']) {
                    sh """
                        # 1. Stop the host Nginx service so Docker can use port 80
                        ssh -o StrictHostKeyChecking=no ubuntu@${WEB_SERVER_IP} 'sudo systemctl stop nginx || true'
                        
                        # 2. Transfer the workspace files to the Web Server
                        scp -o StrictHostKeyChecking=no -r * ubuntu@${WEB_SERVER_IP}:/home/ubuntu/
                        
                        # 3. Build the Docker Image on the Web Server
                        ssh -o StrictHostKeyChecking=no ubuntu@${WEB_SERVER_IP} 'sudo docker build -t devops-app /home/ubuntu/'
                        
                        # 4. Stop any old containers and run the new one
                        ssh -o StrictHostKeyChecking=no ubuntu@${WEB_SERVER_IP} 'sudo docker stop my-app || true'
                        ssh -o StrictHostKeyChecking=no ubuntu@${WEB_SERVER_IP} 'sudo docker rm my-app || true'
                        ssh -o StrictHostKeyChecking=no ubuntu@${WEB_SERVER_IP} 'sudo docker run -d --name my-app -p 80:80 devops-app'
                    """
                }
            }
        }
    }
}
