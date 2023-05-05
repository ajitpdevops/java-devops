remote_state_key="PROD/baseinfra.tfstate"
remote_state_bucket="ecs-terraform-backend-state"

service_name = "springbootapp"
environment = "prod"
desired_task_count = "2"
launch_type = "FARGATE"
aws_region = "us-east-1"
memory = 2048
cpu = 1024

docker_image_url_1 = "whoajitpatil/src-coupon-app:latest"
docker_image_url_2 = "whoajitpatil/src-product-app:latest"
frontend_image_url = "nginx:latest"
frontend_container_port = 80