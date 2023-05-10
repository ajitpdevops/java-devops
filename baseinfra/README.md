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
11. Load Balancer - Created the following for Load balancer
    - ALB - Application Load Balancer
    - Target Group - Target group for 80
    - Listener for 443
12. ECS Task Definition - 3 task definitions for 3 microservices 

### Commands -
1. terraform init -backend-config="./env/baseinfra-prod.config"
2. terraform plan -var-file="./env/production.tfvars" -out="production.tfplan"
3. terraform apply -var-file="./env/production.tfvars"
4. terraform destroy -var-file="./env/production.tfvars"