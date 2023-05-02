variable "aws_region" {
  default     = "us-east-1"
  description = "AWS REGION"
}


variable "environment" {
  default     = "DEV"
  description = "Environment name used a sprefix"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "public_subnet_1a_cidr_block" {
  description = "value of the public subnet 1a cidr block"
  default = "10.0.1.0/24"
}

variable "public_subnet_1b_cidr_block" {
  description = "value of the public subnet 1b cidr block"
  default = "10.0.2.0/24"
}

variable "private_subnet_1a_cidr_block" {
  description = "value of the private subnet 1a cidr block"
  default = "10.0.10.0/24"
}

variable "private_subnet_1b_cidr_block" {
  description = "value of the private subnet 1b cidr block"
  default = "10.0.11.0/24"
}

variable "elastic_ip_for_nat_gateway" {
  description = "value of the elastic ip for nat gateway public ip"
  default = "10.0.0.5"

}

variable "spring_1_port" {
  description = "value of the spring boot app 1 port"
  default     = 8080
}

variable "spring_2_port" {
  description = "value of the spring boot app 2 port"
  default     = 8081
}

variable "frontend_port" {
  description = "value of the frontend app port"
  default     = 3000
}

variable "rds_port" {
  description = "value of the postgres port"
  default     = 5432
}

variable "rds_identifier" {
  description = "value of the postgres identifier"
  default     = "postgres"
}

variable "rds_allocated_storage" {
  description = "value of the postgres allocated storage"
  default     = 20
}

variable "rds_engine" {
  description = "value of the postgres engine"
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "value of the postgres engine version"
  default     = "15.2"
}

variable "rds_storage_type" {
  description = "value of the postgres storage type"
  default     = "gp2"
}

variable "rds_multi_az" {
  description = "value of the postgres multi az"
  default     = "false"
}

variable "rds_public_access" {
  description = "value of the postgres public access"
  default     = "false"
}

variable "rds_instance_class" {
  description = "value of the postgres instance class"
  default     = "db.t3.micro"
}

variable "rds_database_name" {
  description = "value of the postgres database name"
  default     = "postgres"
}

variable "rds_username" {
  description = "value of the postgres username"
  default     = "postgres"
}

variable "rds_password" {
  description = "value of the postgres password"
  default     = "postgres"
}

variable "final_snapshot_identifier" {
  description = "value of the postgres final snapshot identifier"
  default     = "postgres-final-snapshot"
}

variable "ecs_cluster_name" {
  description = "value of the ecs cluster name"
  default     = "app-ecs-cluster"
}

variable "ecr_repo_name" {
  default = "springboot"
}

variable "lb_certificate_arn" {
  description = "value of the lb certificate arn"
  default = "arn:aws:acm:us-east-1:243302161856:certificate/cde28de9-e4fb-4a5b-b17d-7954008353b3"
}

variable "container_insights" {
  description = "value of the container insights"
  default     = true
}