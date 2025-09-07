pipeline {
    agent {
        label 'dotnet-agent'
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
                bat 'dotnet clean'
            }
        }
    }
}
