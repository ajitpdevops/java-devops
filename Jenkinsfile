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
            when { not { environment name: 'SkipPull', value: 'true' } } 
            parallel {
                stage('${SERVICE_NAME} Checkout') {
                    when { expression { SERVICE_NAME == 'couponservice' } }
                    environment {
                        REPO_PATH = "src/${SERVICE_NAME}"
                    }
                    steps {
                        dir(SERVICE_NAME) {
                            checkout(poll: false, changelog: true,
                                scm: [
                                    $class: 'GitSCM', branches: [[name: "${BRANCH}"]],
                                    browser: [$class: 'GithubWeb', repoUrl: "${REPO_URL}"],
                                    doGenerateSubmoduleConfigurations: false,
                                    extensions: [
                                        [$class: 'CloneOption', honorRefspec: true, noTags: false, reference: '', shallow: false, timeout: 60],
                                        [$class: 'SparseCheckoutPaths', 
                                            sparseCheckoutPaths: [
                                                [path: "${REPO_PATH}"]
                                        ]],
                                        [$class: 'CleanBeforeCheckout']
                                    ],
                                    userRemoteConfigs: [[
                                        credentialsId: "${GIT_CREDENTIALS}", 
                                        url: "${REPO_URL}"
                                        ]]
                                ]
                            )
                        }
                    }

                }

        }
        stage('Deploy') {
            steps {
                sh 'mvn clean package'
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