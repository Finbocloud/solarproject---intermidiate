pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'SELECT TO EITHER APPLY OR DESTROY')
    }
    environment {
        // Define environment variables if needed
        //TF_VERSION = '3.99.0' // Example: Set your Terraform version
        TERRAFORM_REPO = 'https://github.com/franklynandco/solarproject'
    }

    stages {
        stage('Checkout Terraform Repository') {
            steps {
                // Checkout the Terraform repository from the 'main' branch
                git branch: 'main', url: TERRAFORM_REPO
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    withCredentials([
                        azureServicePrincipal(credentialsId: 'azure-service-principal', subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', clientIdVariable: 'ARM_CLIENT_ID', clientSecretVariable: 'ARM_CLIENT_SECRET', tenantIdVariable: 'ARM_TENANT_ID'),
                        
                    ]) {
                        // Login to Azure using service principal
                        bat "az login --service-principal -u %ARM_CLIENT_ID% -p %ARM_CLIENT_SECRET% --tenant %ARM_TENANT_ID%"
                        echo "INITIALIZING TERRAFORM"
                        bat 'terraform init'
                        echo "TERRAFORM INITIALIZED SUCCESSFUL"
                        echo "VALIDATING TERRAFORM" 
                        bat 'terraform validate'
                        echo "TERRAFORM VALIDATED SUCCESSFUL" 
                    }
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                script {
                    // Only plan if ACTION is 'apply'
                    if (params.ACTION == 'apply') {
                        withCredentials([
                            azureServicePrincipal(credentialsId: 'azure-service-principal', subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', clientIdVariable: 'ARM_CLIENT_ID', clientSecretVariable: 'ARM_CLIENT_SECRET', tenantIdVariable: 'ARM_TENANT_ID'),
                            
                        ]) {
                            // Login to Azure using service principal
                            bat "az login --service-principal -u %ARM_CLIENT_ID% -p %ARM_CLIENT_SECRET% --tenant %ARM_TENANT_ID%"
                            bat 'terraform plan -out tf.plan'
                        }
                    
                    }
                }
            }
        }

        stage('Apply or Destroy Terraform') {
            steps {
                script {
                   if (params.ACTION == 'apply') {
                    withCredentials([
                        azureServicePrincipal(credentialsId: 'azure-service-principal', subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID', clientIdVariable: 'ARM_CLIENT_ID', clientSecretVariable: 'ARM_CLIENT_SECRET', tenantIdVariable: 'ARM_TENANT_ID'),
                        
                    ]) {
                        // Login to Azure using service principal
                        bat "az login --service-principal -u %ARM_CLIENT_ID% -p %ARM_CLIENT_SECRET% --tenant %ARM_TENANT_ID%"
                            
                                bat 'terraform apply -auto-approve tf.plan'
                    }
                    }else if (params.ACTION == 'destroy'){
                                bat 'terraform destroy -auto-approve'
                   }
                        
                    
                }   
                }
            
        }
    }
}