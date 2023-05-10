# Remote State 
remote_state_key="PROD/baseinfra.tfstate"
remote_state_bucket="ecs-terraform-backend-state"

# Environment & Region
environment = "prod"
aws_region = "us-east-1"

# Common Service Parameters 
desired_task_count = "2"


# Manage Microservices 
microservices = {
  cloudline-backend = {
    image_url     = "your-image-url-1"
    container_port  = 8080
    spring_profiles = "dev"
    per_container_cpu = 512
    per_container_memory = 1024
    health_check_path = "/api/health"
  },
  cloudline-auth = {
    image_url     = "your-image-url-2"
    container_port  = 8081
    spring_profiles = "test"
    per_container_cpu = 1024
    per_container_memory = 2048
    health_check_path = "/auth/health"
  },
  cloudline-frontend = {
    image_url     = "your-image-url-3"
    container_port  = 3000
    spring_profiles = "prod"
    per_container_cpu = 512
    per_container_memory = 1024
    health_check_path = "/health"
  }
}