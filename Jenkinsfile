pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Jaydeep-29/terraform_jenkins.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: env.GIT_REPO
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Approval') {
            when {
                not { equals expected: true, actual: params.autoApprove }
            }
            steps {
                script {
                    def plan = readFile 'tfplan'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Review the Terraform plan', defaultValue: plan)]
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'CICD_user', region: 'eu-west-2') {
                    script {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Show Output') {
            steps {
                script {
                    sh 'terraform output'
                }
            }
        }
    }
}
