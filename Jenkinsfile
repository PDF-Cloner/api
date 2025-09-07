pipeline {
    agent any

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

    //     stage('Test') {
    //         steps {
    //             // Run unit tests (adjust path if your tests are elsewhere)
    //             withEnv(["PATH+DOTNET=${env.DOTNET_HOME}/bin"]) {
    //                 sh "dotnet test ./tests/YourProject.Tests/YourProject.Tests.csproj --configuration ${env.BUILD_CONFIGURATION} --no-build --verbosity normal --logger \"trx;LogFileName=test-results.trx\""
    //             }
    //             // Publish test results
    //             junit allowEmptyResults: true, testResults: '**/test-results.trx'
    //         }
    //     }

    //     stage('Publish') {
    //         steps {
    //             // Publish the Web API to a folder
    //             withEnv(["PATH+DOTNET=${env.DOTNET_HOME}/bin"]) {
    //                 sh "dotnet publish ./src/YourProject.WebApi/YourProject.WebApi.csproj --configuration ${env.BUILD_CONFIGURATION} --output publish"
    //             }
    //             // Archive the published artifacts
    //             archiveArtifacts artifacts: 'publish/**', fingerprint: true
    //         }
    //     }

    //     stage('Deploy') {
    //         when {
    //             branch 'main'
    //         }
    //         steps {
    //             // Example: Copy to remote or trigger deployment job
    //             echo 'Deploying to production...'
    //             // sh 'scp -r publish/* user@server:/var/www/yourapi'
    //         }
    //     }
    // }

    // post {
    //     always {
    //         // Clean workspace after build
    //         cleanWs()
    //     }
    //     success {
    //         echo 'Build and tests succeeded!'
    //     }
    //     failure {
    //         echo 'Build or tests failed.'
    //     }
    // }
}
