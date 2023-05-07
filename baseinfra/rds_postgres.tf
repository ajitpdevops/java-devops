
# create db subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "postgres-db-subnet-group"
  description = "postgres db subnet group"
  subnet_ids  = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}

resource "aws_db_parameter_group" "db-parameter-group" {
  name        = "postgres-db-parameter-group"
  family      = "postgres15"
  description = "postgres db parameter group"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  parameter {
    name  = "pg_stat_statements.track"
    value = "all"
  }

  tags = {
    Name = "${var.environment}-db-parameter-group"
  }
  
}


# Create a Postgres RDS cluster within my VPC and subnets

resource "aws_db_instance" "rds-instance" {
  identifier                  = var.rds_identifier
  allocated_storage           = var.rds_allocated_storage
  storage_type                = var.rds_storage_type
  multi_az                    = var.rds_multi_az
  engine                      = var.rds_engine
  engine_version              = var.rds_engine_version
  instance_class              = var.rds_instance_class
  db_name                     = var.rds_database_name
  # username                    = var.local.db_creds.username
  # password                    = var.local.db_creds.password
  username                    = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["username"]
  password                    = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["password"]
  port                        = var.rds_port
  publicly_accessible         = var.rds_public_access
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  apply_immediately           = true
  storage_encrypted           = false
  skip_final_snapshot         = true
  final_snapshot_identifier   = var.final_snapshot_identifier
  vpc_security_group_ids      = [aws_security_group.rds-sg.id, aws_security_group.ecs-sg.id]
  db_subnet_group_name        = "${aws_db_subnet_group.db_subnet_group.name}"

  tags = {
    Name = "${var.rds_identifier}-db-instance"
  }

  depends_on = [ aws_secretsmanager_secret_version.sversion ]

}
