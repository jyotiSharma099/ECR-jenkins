pipeline {
    agent any
    stages {
                  stage('verify') {
                    steps {
                     git([url: 'https://github.com/jyotiSharma099/ECR-jenkins.git', branch: 'main'])
					 sh 'sudo apt install docker.io -y'
                     sh 'ls -lhtr'
                     sh 'pwd'
                     sh 'docker --version'
                     sh 'docker images'
                     sh 'docker ps'
        }
    }
                  stage('Build') {
                   steps {
                   sh 'sudo docker build -t wordpress:v1 .'
            }
                }
                stage('Docker test') {
                   steps {
                   sh 'sudo docker run -d -p 8089:80  wordpress:v1'
                 
            }
                }

}
}
