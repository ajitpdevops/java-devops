# JAVA SpringBoot Microservices CI/CD DevOps Project

## Prerequisites
- Set up WSL2 with Ubuntu 20.04 + (preferably 22.04)
- OS Windows 11 22H2
- AWS Free Tier Account
- Github Account
- Postman API Testing tool 
- VSCode 

## Setup Inside WSL Ubuntu
- Make a bin directory in our user home directory to store binaries.
    - mkdir -p ~/bin

- Add the new bin directory to our Path.
    - echo export PATH=\$PATH:~/bin >> ~/.bashrc && source ~/.bashrc

- Create a "repos" to work on your project
    - mkdir -p ~/repos

- Docker version 20.10.21
    - sudo apt install apt-transport-https ca-certificates curl software-properties-common
    - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    - sudo apt update && sudo apt install docker-ce
    - sudo usermod -aG docker ${USER} && su - ${USER}
    - sudo service docker start
    - docker ps

- docker-compose version 1.29.2
    - sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64" -o ~/bin/docker-compose
    - sudo chmod +x ~/bin/docker-compose
    - docker-compose --version

- Terraform v1.3.5
    - curl https://releases.hashicorp.com/terraform/1.3.5/terraform_1.3.5_linux_amd64.zip -o "terraform.zip" && unzip terraform.zip
    - sudo mv terraform ~/bin/
    - terraform --version

- aws-cli/2.0.30
    - sudo apt install python3-pip unzip
    - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" && unzip awscliv2.zip
    - ./aws/install -i ~/bin/awscli -b ~/bin
    - aws --version

- openjdk 11.0.17
    - sudo apt-get install openjdk-11-jdk
    - java --version

- maven 3.6.3
    - curl https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o "apache-maven-3.6.3-bin.tar.gz"
    - tar -xvf apache-maven-3.6.3-bin.tar.gz
    - mv apache-maven-3.6.3 ~/bin/
    - M2_HOME='~/bin/apache-maven-3.6.3'
    - PATH="$M2_HOME/bin:$PATH"
    - export PATH

- VSCode extensions installed for WSL 
    * Docker
    * Java Extension Pack 
    * HashiCorp Terraform
    * Gitlens
    * Spring Boot Extension Pack
    * MySQL Extension

## Get Started with the Project 
1. Clone the Git Repository in WSL at your "repos" location
2. Start the Docker service
3. 

## Creating a springboot project
1. Create a new Spring Project with Maven
2. Dependancies 
    - Spring JPA for Data
    - MySQL Driver 
    - Spring web 
    - Postgres driver [for postgres datasource]
3. To Run the database image in isolation
    - sudo docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres

## Building the projects in Maven containers - 
1. To build the couponservice app, execute [docker-compose run --rm mvn-coupon clean package -DskipTests]
2. To build the productservice app, execute [docker-compose run --rm mvn-product clean package -DskipTests]

## Run all microservice together with Docker-Compose 
docker-compose up product-app

## Postman calls to create Coupon & Products
- Create a coupon 
{
    "code":"XMAS",
    "discount":25,
    "expDate":"26/12/2022"
}

- Create a product 
{
    "name":"X-mas Tree",
    "description": "A must have in your Xmas decoration",
    "price": 75,
    "couponCode": "XMAS"
}

# Build the images using docker compose 
docker compose build --no-cache coupon-app
docker compose build --no-cache product-app

## ECR Login and push images to ECR

- aws ecr get-login-password --region region | docker login --username AWS --password-stdin 243302161856.dkr.ecr.us-east-1.amazonaws.com
- docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 243302161856.dkr.ecr.us-east-1.amazonaws.com

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 243302161856.dkr.ecr.us-east-1.amazonaws.com
docker images
docker tag src-product-app:latest 243302161856.dkr.ecr.us-east-1.amazonaws.com/product:latest
docker push 243302161856.dkr.ecr.us-east-1.amazonaws.com/product:latest

docker tag src-coupon-app:latest 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest
docker push 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres --network microservices -d postgres

docker run --name coupon-serv -p 8081:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgresdb:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon

## Setting up Terraform Automation
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
6. Create db subnet group 
7. Create a Postgres RDS cluster within private subnets
8. 

A Virtual Private Cloud with Public and private subnets
Internet Gateway to contact the outer world
Security groups for RDS Postgres and for ECS
A Load balancer distributing traffic between containers & database
RDS Postgres instance
Auto scaling group for ECS cluster with launch configuration
ECS cluster with task and service definition

### Commands -
1. terraform init -backend-config="./env/baseinfra-prod.config"
2. terraform plan -var-file="./env/production.tfvars" -out="production.tfplan"
3. terraform apply -var-file="./env/production.tfvars"
4. terraform destroy -var-file="production.tfvars"

updating Security Group (sg-08770c64a8fd42396) ingress rules: updating rules: from_port (80) and to_port (80) must both be 0 to use the 'ALL' "-1" protocol!


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
11. Load Balancer - Created the following for Load balancer
    - ALB - Application Load Balancer
    - Target Group - Target group for 80
    - Listener for 443

## Setting up Platform Infra Automation
- LB Target group LB for each microservice
- LB Listener Rule for each microservice
- ECS Task Defition each microservice
- ECS Service for each microservice
- Cloudwatch log group for each microservices
- Autoscaling group for each microservice
    - Autoscaling policy for memory utilization
    - Autoscaling policy for CPU utilization


terraform apply -target="aws_db_instance.*" -target="aws_secretsmanager_secret.*"

terraform apply -target="aws_db_instance.*" -target="aws_secretsmanager_secret.*" -target="random_password.*" -target="aws_secretsmanager_secret_version.*"
terraform plan -target="aws_db_instance.*" -target="aws_secretsmanager_secret.*" -target="random_password.*" -target="aws_secretsmanager_secret_version.*"
