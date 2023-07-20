pipeline {
    agent any
    environment {
        DOCKER_CONFIG = '/tmp/.docker'
    }
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
                sh 'sudo docker run -d -p 8084:80 wordpress:v1'
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
                    sh 'mkdir -p $DOCKER_CONFIG'
                    sh 'echo "{\"credHelpers\":{\"007340509278.dkr.ecr.us-east-1.amazonaws.com\":\"ecr-login\"}}" > $DOCKER_CONFIG/config.json'
                    sh 'docker login --username AWS --password-stdin 007340509278.dkr.ecr.us-east-1.amazonaws.com < $DOCKER_CONFIG/config.json'
                    sh 'sudo docker tag wordpress:v1 007340509278.dkr.ecr.us-east-1.amazonaws.com/wordpress:v1'
                    sh 'sudo docker push 007340509278.dkr.ecr.us-east-1.amazonaws.com/wordpress:v1'
                    sh 'rm -rf $DOCKER_CONFIG'
                }
            }
        }
    }
}
