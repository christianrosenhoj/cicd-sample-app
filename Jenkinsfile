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
                git 'https://github.com/christianrosenhoj/cicd-sample-app.git' // Correct URL
            }
        }
        stage('Build') {
            when {
                changeset '**/*'
            }
            steps {
                build 'BuildSampleApp'
            }
        }
        stage('Results') {
            when {
                changeset '**/*'
            }
            steps {
                build 'TestSampleApp'
            }
        }
    }
}
