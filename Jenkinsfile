pipeline {
    agent {
        label 'agent'
    }
    environment {
        GIT_CREDENTIALS = '5f03c196-0173-4c72-84a7-44092e117cd7'
        REPO_URL = 'https://github.com/ajitpdevops/java-devops.git'
        BRANCH = 'main'
        SERVICE_NAME = 'couponservice' // Change this to the desired service
    }
    tools {
        maven 'Maven3'
        jdk 'Java17'
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from SCM') {
            steps {
                script {
                    def repoPath = "src/${SERVICE_NAME}"

                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/${BRANCH}']],
                        extensions: [
                            [$class: 'SparseCheckoutPaths', sparseCheckoutPaths: [[path: repoPath]]],
                            [$class: 'CleanBeforeCheckout']
                        ],
                        userRemoteConfigs: [[
                            url: "${REPO_URL}",
                            credentialsId: "${GIT_CREDENTIALS}"
                        ]]
                        ])
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'mvn deploy'
            }
        }
    }
    post {
        always {
            'Build Completed'
        }
        success {
            'Build Success'
        }
        failure {
            'Build Failed'
        }
    }
}