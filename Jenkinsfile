pipeline {
    agent {
        label 'dotnet-agent'  // Ensure label matches your Jenkins .NET SDK config
    }

    environment {
        BUILD_CONFIGURATION = 'Release'
    }

    options {
        timeout(time: 60, unit: 'MINUTES')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Dotnet') {
            steps {
                script {
                    env.DOTNET_HOME = tool name: 'dotnet-sdk-9.0', type: 'com.microsoft.net.sdk'
                }
            }
        }

        stage('Restore') {
            steps {
                withEnv(["PATH+DOTNET=${env.DOTNET_HOME}\\bin"]) {
                    bat 'dotnet restore'
                }
            }
        }

        stage('Build') {
            steps {
                withEnv(["PATH+DOTNET=${env.DOTNET_HOME}\\bin"]) {
                    bat "dotnet build --configuration ${env.BUILD_CONFIGURATION} --no-restore"
                }
            }
        }
    }
}
