# A repository for the DevOps Assesssment
## Requirements
1. Kubernetes-cli
2. minikube, must be running
3. Terraform cli
4. A minikube-ip.txt file with the minikube ip
5. A Web browser
## Setup Guidelines
1. Assumes that you are running from within the build/terraform/ directory
2. Start minikube: minikube start
3. Run minikube ip > ../../config_files/minikube-ip.txt 
4. Build using terraform: terraform apply (can optionally run with --auto-approve)
