variable "aws_region" {
  description = "Default AWS region"
  default     = "us-east-1"
}

variable "environment" {
  default     = "dev"
}

variable "remote_state_bucket" {}
variable "remote_state_key" {}

# Common Application Variables 

variable "ecs_task_definition_family" {
    default = "springboot-task-definition"
}

variable "launch_type" {
    default = "FARGATE"
}


# This map must be defined in the respective environment's tfvar file
variable "microservices" {
  type = map(object({
    image_tag             = string
    container_port        = number
    spring_profiles       = string
    per_container_cpu     = number
    per_container_memory  = number
    health_check_path     = string
    database_name         = string
    desired_task_count    = number
  }))
  description = "A map of microservices to be deployed"
}