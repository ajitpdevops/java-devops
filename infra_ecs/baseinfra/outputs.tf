output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_1a_id" {
  value = aws_subnet.public-subnet-1a.id
}

output "public_subnet_1b_id" {
  value = aws_subnet.public-subnet-1b.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private-subnet-1a.id
}

output "private_subnet_1b_id" {
  value = aws_subnet.private-subnet-1b.id
}

output "private_subnets" {
  value = tolist([aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id])
}

output "public_subnets" {
  value = tolist([aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id])
}


output "rds_endpoint" {
  value = aws_db_instance.rds-instance.endpoint
}

output "ecs_alb_listener_arn" {
  value = aws_lb_listener.ecs-alb-https-listener.arn
}

output "alb-dns-name" {
  value = aws_lb.main-alb.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_cluster_role_name" {
  value = aws_iam_role.ecs-cluster-role.name
}

output "ecs_cluster_role_arn" {
  value = aws_iam_role.ecs-cluster-role.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "secret_string" {
  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.creds.secret_string))
}

# Output the secret manger arn 
output "secret_manager_arn" {
  value = aws_secretsmanager_secret.secretmasterDB.arn
}

output "ecs-sg-id" {
  value = aws_security_group.ecs-sg.id
}

# output "ecr_repositories" {
#   value = aws_ecr_repository.microservices
# }

# Output the ecr_repositories created in aws_ecr_repository block

output "ecr_repositories" {
  value = {
    for key, repository in aws_ecr_repository.microservices : key => repository.repository_url
  }
}