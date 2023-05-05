variable "aws_region" {
  description = "Default AWS region"
  default     = "us-east-1"
}

variable "environment" {
  default     = "dev"
}

variable "remote_state_bucket" {

}

variable "remote_state_key" {

}

# Common Application Variables 
variable "service_name" {
  default = "springbootapp"
}

variable "health_check_path" {
  default = "/"
}

variable "ecs_task_definition_family" {
    default = "springboot-task-definition"
}

variable "launch_type" {
  default = "FARGATE"
}

variable "requires_compatibility" {
  default = "FARGATE"
}

variable "desired_task_count" {
  default = 2
}

variable "cpu" { }
variable "memory" { }



# SpringBoot Application 1 Variables for tasks
variable "ecs_service_name_1" {
  default = "springboot-app-1"
}

variable "app1_health_check_path" {
  default = "/"
}

variable "docker_image_url_1" {
}

variable "container_port_1" {
  type = number
  default = 8080
}

variable "spring_profiles_1" {
  default = "dev"
}

variable "memory_reservation_1" {
  default = 1024
}

variable "cpu_1" {
  default = 256

}

# SpringBoot Application 2 Variables for tasks
variable "ecs_service_name_2" {
  default = "springboot-app-2"
}

variable "app2_health_check_path" {
  default = "/"
}


variable "docker_image_url_2" {
}

variable "container_port_2" {
  default = 8081
}

variable "spring_profiles_2" {
  default = "dev"
}

variable "memory_reservation_2" {
  default = 1024
}

variable "cpu_2" {
  default = 256

}

# Front End Application Variables
variable "frontend_container_name" {
  default = "frontend"
}

variable "frontend_image_url" {
}

variable "frontend_container_port" {
  default = 3000
}

variable "memory_reservation_3" {
  default = 1024
}

variable "cpu_3" {
  default = 256
}
