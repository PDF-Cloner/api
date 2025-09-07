pipeline {
    agent {
        label 'dotnet-agent'
    }
    options {
        timeout(time: 60, unit: 'MINUTES')
    }
    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('API Project') {
            steps {
                bat 'dotnet clean'
                bat 'dotnet restore'
                bat "dotnet build --no-restore"
            }
        }

        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        dir('Tests/UT') {
                            bat 'dotnet clean'
                            bat 'dotnet restore'
                            bat "dotnet build --no-restore"
                            bat 'dotnet test --no-build'
                        }
                    }
                }
                stage('Integration Tests') {
                    steps {
                        dir('Tests/IT') {
                            bat 'dotnet clean'
                            bat 'dotnet restore'
                            bat "dotnet build --no-restore"
                            bat 'dotnet test --no-build'
                        }
                    }
                }
                stage('E2E Tests') {
                    steps {
                        dir('Tests/E2E') {
                            bat 'dotnet clean'
                            bat 'dotnet restore'
                            bat "dotnet build --no-restore"
                            bat 'dotnet test --no-build'
                        }
                    }
                }
            }
        }
    }
}
