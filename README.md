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
    - sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o ~/bin/docker-compose
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

## Building the projects in Maven containers - 
1. To build the productservice app, execute [docker-compose run --rm mvn-product clean package -DskipTests]
2. To build the couponservice app, execute [docker-compose run --rm mvn-coupon clean package -DskipTests]


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

