pipeline {
    agent {
        label 'agent'
    }
    parameters {
        string(name: 'Service', defaultValue: 'couponservice', description: 'Service Name')
    }
    environment {
        GIT_CREDENTIALS = '5f03c196-0173-4c72-84a7-44092e117cd7'
        REPO_URL = 'https://github.com/ajitpdevops/java-devops.git'
        BRANCH = 'MCS-003'
        SERVICE_NAME = "${params.Service}"
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
                                // [$class: 'CloneOption', honorRefspec: true, noTags: false, reference: '', shallow: false, timeout: 60],
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
        stage('Build Service') {
            steps {
                script {
                    sh 'pwd'
                    sh 'mvn -f couponservice/src/couponservice/pom.xml clean package -Dspring.profiles.active=dev'
                }
            }
        }
        stage('Test Service') {
            steps {
                script {
                    sh 'mvn -f couponservice/src/couponservice/pom.xml test -Dspring.profiles.active=dev'
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
                        sh 'mvn -f couponservice/src/couponservice/pom.xml verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=cyberlysafe_java-springboot-microservices -Dspring.profiles.active=dev'
                    }
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    waitForQualityGate abortPipeline: true, credentialsId: 'sonarqube', id: 'cyberlysafe_java-springboot-microservices', timeout: 300
                }
            }
        }
    }
}