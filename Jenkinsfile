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
                bat 'dotnet build --no-restore'
            }
        }
        stage('Unit Tests') {
            steps {
                dir('Tests/UT') {
                    bat 'dotnet clean'
                    bat 'dotnet restore'
                    bat 'dotnet build --no-restore'
                    bat 'dotnet test --no-build --collect:"XPlat Code Coverage"'
                }
            }
        }
        stage('Publish Coverage') {
            steps {
                step([
                    $class: 'CoveragePublisher',
                    sourceFileResolver: [$class: 'SourcePathResolver'],
                    adapters: [
                        [$class: 'CoberturaAdapter', coberturaReportFile: '**/TestResults/**/coverage.cobertura.xml']
                    ]
                ])
            }
        }
        // stage('Integration Tests') {
        //     steps {
        //         dir('Tests/IT') {
        //             bat 'dotnet clean'
        //             bat 'dotnet restore'
        //             bat 'dotnet build --no-restore'
        //             bat 'dotnet test --no-build'
        //         }
        //     }
        // }
        stage('E2E Tests') {
            steps {
                dir('Tests/E2E') {
                    bat 'dotnet clean'
                    bat 'dotnet restore'
                    bat 'dotnet build --no-restore'
                    bat 'dotnet test --no-build'
                }
            }
        }
    }
}
