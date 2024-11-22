pipeline {
    agent any
    environment {
        ECR_URI = "<account_id>.dkr.ecr.<region>.amazonaws.com/s3-to-rds-or-glue"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/<username>/S3_to_RDS_or_Glue.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t s3-to-rds-or-glue .'
                sh 'docker tag s3-to-rds-or-glue:latest $ECR_URI:latest'
            }
        }
        stage('Push to ECR') {
            steps {
                sh 'aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin $ECR_URI'
                sh 'docker push $ECR_URI:latest'
            }
        }
        stage('Deploy Terraform') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
