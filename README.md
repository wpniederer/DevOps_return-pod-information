# A repository for the DevOps Assesssment
## Requirements
1. Kubernetes-cli
2. minikube, must be running
3. Terraform cli
4. A minikube-ip.txt file with the minikube ip
5. A Web browser
## Setup Guidelines
1. Assumes that you are running from within the "build/terraform/" directory
2. Start minikube: minikube start
3. Run minikube ip > ../../config_files/minikube-ip.txt 
4. Initialize terraform: terraform init
5. Build using terraform: terraform apply (can optionally run with --auto-approve)
## Link to Docker repository 
https://hub.docker.com/repository/docker/wpniederer/return-pod-details-app/general
## Instructions for what needs to be changed to deploy to AWS EKS
1. An AWS Account with an IAM user with the proper permissions
2. Configure AWS CLI
3. Push docker image to AWS ECR
4. Write the terraform templates for creating the appropriate kubernetes resources, services and infrastucture
5. Configure kubectl to point to the AWS EKS cluster
6. Deploy the web app image
