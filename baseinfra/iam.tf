resource "aws_iam_role" "ecs-cluster-role" {
  name = "ecs-IAM-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ecs.amazonaws.com", "ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
        }
      },
    ]
  })
}

resource "aws_iam_policy" "ecs-cluster-policy" {
  name        = "ecs-task-policy"
  description = "Policy that allows access to required resources for ECS Cluster"

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
                "ecs:*",
                "ec2:*",
                "ecr:*",
                "dynamodb:*",
                "cloudwatch:*",
                "s3:*",
                "rds:*",
                "sqs:*",
                "sns:*",
                "logs:*",
                "ssm:*",
                "elasticloadbalancing:*",
                "elasticfilesystem:*",
                "autoscaling:*",
                "application-autoscaling:*",
                "secretmanager:*",
                "route53:ChangeResourceRecordSets",
                "route53:CreateHealthCheck",
                "route53:DeleteHealthCheck",
                "route53:Get*",
                "route53:List*",
                "route53:UpdateHealthCheck"
           ],
           "Resource": "*"
       }
   ]
}
EOF
}  

resource "aws_iam_role_policy_attachment" "ecs-cluster-policy-attachment" {
  role       = aws_iam_role.ecs-cluster-role.name
  policy_arn = aws_iam_policy.ecs-cluster-policy.arn
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-TaskExecutionRole"
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
    }
    EOF
}


resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
