pipeline {
    agent {
        label 'dotnet'
    }

    environment {
        DOTNET_HOME = tool name: 'dotnet-sdk-9.0', type: 'com.microsoft.net.sdk' 
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

        stage('Restore') {
            steps {
                withEnv(["PATH+DOTNET=${env.DOTNET_HOME}/bin"]) {
                    sh 'dotnet restore'
                }
            }
        }

        stage('Build') {
            steps {
                withEnv(["PATH+DOTNET=${env.DOTNET_HOME}/bin"]) {
                    sh "dotnet build --configuration ${env.BUILD_CONFIGURATION} --no-restore"
                }
            }
        }
    }
}
