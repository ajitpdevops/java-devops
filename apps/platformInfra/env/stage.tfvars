# Remote State 
remote_state_key="PROD/baseinfra.tfstate"
remote_state_bucket="ecs-terraform-backend-state"

# Environment
environment = "prod"

# Service Names 
microservice_1 = "coupon"
microservice_2 = "product"
frontend_service = "frontend"

# ECS Cluster
desired_task_count = "2"
aws_region = "us-east-1"
per_container_memory = 2048
per_container_cpu = 1024

docker_image_url_1 = "whoajitpatil/src-coupon-app:latest"
docker_image_url_2 = "whoajitpatil/src-product-app:latest"
frontend_image_url = "nginx:latest"
frontend_container_port = 80