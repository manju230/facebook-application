pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO   = 'facebook-application'
        ACCOUNT_ID = '848004113365'
        IMAGE_TAG  = "${BUILD_NUMBER}"  // Better than 'latest'
        IMAGE_URI  = "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manju230/facebook-application.git'
                    // remove credentialsId if repo is public or using IAM
            }
        }

        stage('Login to ECR') {
            steps {
                sh """
                aws ecr get-login-password --region ${AWS_REGION} \
                | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                """
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('facebook-app') {
                    sh """
                    docker build -t ${ECR_REPO}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh """
                docker tag ${ECR_REPO}:${IMAGE_TAG} ${IMAGE_URI}
                """
            }
        }

        stage('Push to ECR') {
            steps {
                sh """
                docker push ${IMAGE_URI}
                """
            }
        }
    }

    post {
        success {
            echo "✅ Image pushed successfully: ${IMAGE_URI}"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}
