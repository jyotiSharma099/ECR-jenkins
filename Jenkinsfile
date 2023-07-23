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
                sh 'sudo docker run -d -p 8084:80 wordpress:v1'
            }
        }
        stage('AWS Configure') {
            steps {
                script {
                        withCredentials([
                            [
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'aws-credentials',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                            ]
                        ]) {
                            sh 'AWS_PASSWORD=$(aws ecr-public get-login-password --region us-east-1)'
                            sh 'sudo echo $AWS_PASSWORD | sudo docker login --username AWS --password-stdin public.ecr.aws/p4z1i4n3'
                            sh 'sudo docker tag wordpress:latest public.ecr.aws/p4z1i4n3/wordpress:latest'
                            sh 'sudo docker push public.ecr.aws/p4z1i4n3/wordpress:latest'
                        }
                    }
                }
            }
        }
    }
