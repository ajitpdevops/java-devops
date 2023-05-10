resource "aws_iam_role" "fargate-iam-role" {
  name               = "${var.service_name}-IAM-Role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
            },
            "Effect": "Allow"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy" "fargate-iam-policy" {
  name   = "${var.service_name}-IAM-Policy"
  role   = aws_iam_role.fargate-iam-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:*",
        "ecr:*",
        "logs:*",
        "cloudwatch:*",
        "elasticloadbalancing:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
