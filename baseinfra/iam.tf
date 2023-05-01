resource "aws_iam_role" "ecs-cluster-role" {
    name               = "${var.ecs_cluster_name}-IAM-Role"
    assume_role_policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                Service = ["ecs.amazonaws.com","ec2.amazonaws.com","application-autoscaling.amazonaws.com"]
                }
            },
            ]
        })
}