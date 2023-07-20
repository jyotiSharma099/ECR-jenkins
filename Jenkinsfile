pipeline {
    agent any
    stages {
                  stage('Clone repository') {
                    steps {
                     git([url: 'https://github.com/jyotiSharma099/ECR-jenkins.git', branch: 'main'])
		     sh 'sudo apt install docker.io -y'
                     sh 'sudo docker --version'
                     sh 'sudo docker images'
                     sh 'sudo docker ps'
        }
    }
                  stage('Build') {
                   steps {
                   sh 'sudo docker build -t wordpress:v1 .'
		   sh 'sudo docker images'
            }
                }
                stage('Docker test') {
                   steps {
                   sh 'sudo docker run -d -p 8086:80  wordpress:v1'
                 
            }
                }
	        stage('AWS Configure') {
                   steps {
                       withCredentials([
                           [
                              $class: 'AmazonWebServicesCredentialsBinding',
                              credentialsId: 'aws-credentials',
                              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                              secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                            ]
            ]) {
                sh 'sudo docker push 007340509278.dkr.ecr.us-east-1.amazonaws.com/docker_ecr_repo:latest'
            }
        }
    }

}
}
