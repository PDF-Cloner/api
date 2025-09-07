pipeline {
    agent {
        label 'dotnet-agent'
    }
    options {
        timeout(time: 60, unit: 'MINUTES')
    }
    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN')
    }
    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('SonarCloud Analysis - Begin') {
            steps {
                bat """
                    set PATH=%PATH%;%USERPROFILE%\\.dotnet\\tools
                    dotnet sonarscanner begin ^
                    /k:"pdfcloner_api" ^
                    /o:"pdfcloner" ^
                    /d:sonar.login=%SONAR_TOKEN% ^
                    /d:sonar.host.url="https://sonarcloud.io" ^
                    /d:sonar.coverageReportPaths=**\\coverage.cobertura.xml
                """
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
        stage('SonarCloud Analysis - End') {
            steps {
                bat """
                        set PATH=%PATH%;%USERPROFILE%\\.dotnet\\tools
                        dotnet sonarscanner end /d:sonar.login=%SONAR_TOKEN%
                """
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
