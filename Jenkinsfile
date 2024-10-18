pipeline {
    agent any
    triggers {
        pollSCM('* * * * *') // Polls the SCM every minute
    }
    stages {
        stage('Preparation') {
            steps {
                catchError(buildResult: 'SUCCESS') {
                    sh 'docker stop samplerunning'
                    sh 'docker rm samplerunning'
                }
            }
        }
        stage('Pull from Git') {
            steps {
                git 'https://github.com/christianrosenhoj/cicd-sample-app.git' // Replace with your actual repo URL
            }
        }
        stage('Build') {
            steps {
                build 'BuildSampleApp'
            }
        }
        stage('Results') {
            steps {
                build 'TestSampleApp'
            }
        }
    }
}
