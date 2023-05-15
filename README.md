## Setting up Terraform Automation for Base Infrastructure

1. Set up the provider 
2. Setting up Networking components 
    - Setup VPC 
    - Setup Internet Gateway - IGW & Route table association
    - Public Subnet - 2, Route Table, Route table association 
    - Private Subnets - 2, Route Table, Route table association 
    - Elastic IP for Nat Gatway 
    - Nat Gateway - NGW & Route table association 
3. Security Group for ALB allows port 80 traffic from anywhere
4. Security Group for ECS Clusters [8080, 8081, 3000]
5. Security Group for Postgres RDS [5432]
6. ECS Cluster - 1 new cluster
7. ECR - 3 repositories for 3 microservices
8. RDS - Create a Postgres RDS Instance within private subnets
9. AWS Secret - Random string generated for RDS and pass it to aws_db_instance resource
10. IAM Roles - IAM Role to create with ECS Cluster Creation
11. IAM Role for Task Execution
12. Load Balancer - Created the following for Load balancer
    - ALB - Application Load Balancer
    - Target Group - Target group for 80
    - Listener for 443

### Commands -
1. terraform init -backend-config="./env/baseinfra-prod.config"
2. terraform plan -var-file="./env/production.tfvars" -out="production.tfplan"
3. terraform apply -var-file="./env/production.tfvars"
4. terraform destroy -var-file="./env/production.tfvars"

## Setting up Platform Infra Automation
- LB Target group LB for each microservice
- LB Listener Rule for each microservice
- ECS Task Defition each microservice
- ECS Service for each microservice
- Cloudwatch log group for each microservices
- Autoscaling group for each microservice
    - Autoscaling policy for memory utilization
    - Autoscaling policy for CPU utilization

### Commands -
1. terraform init -backend-config="./env/platforminfra-prod.config"
2. terraform plan -var-file="./env/production.tfvars" -out="production.tfplan"
3. terraform apply -var-file="./env/production.tfvars"
4. terraform destroy -var-file="./env/production.tfvars"

## Setting up Gitlab CI/CD Pipeline
- Gitlab CI/CD Pipeline for each microservice
- Saperate pipeline file for stage and prod environment
    - staging-pipeline.yml
    - production-pipeline.yml

# How to use 
1. Create a new github repository for baseinfra
2. Copy all content from "baseinfra" into the repository
3. Copy "platforminfra" folder into each of your microservices repository
4. Make appropriate changes to the backconfig & tfvars files located under "./platforminfra/env" folders
5. Copy content fron ".github" folder into each of your microservices repository
6. This folder contains a pipeline file for each environment
7. Make appropriate changes to the "*.yml" files located under "./.github/WORKFLOWS" folders


# Common Consideration
1. java 11
2. 