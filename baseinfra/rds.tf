
# create db subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "rds-db-subnet-group"
  description = "rds db subnet group"
  subnet_ids  = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}



#create a RDS Database Instance
resource "aws_db_instance" "rds-endpoint" {
  engine                      = "mysql"
  identifier                  = "myrdsinstance"
  allocated_storage           =  20
  engine_version              = "5.7"
  instance_class              = "db.t3.micro"
  username                    = "admin"
  password                    = "admin12345"
  parameter_group_name        = "default.mysql5.7"
  port                        = var.rds_port
  skip_final_snapshot         = true
  publicly_accessible         =  true
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  apply_immediately           = true
  storage_encrypted           = false
  final_snapshot_identifier   = var.final_snapshot_identifier
  vpc_security_group_ids      = [aws_security_group.rds-sg.id, aws_security_group.ecs-sg.id]
  db_subnet_group_name        = "${aws_db_subnet_group.db_subnet_group.name}"

  tags = {
    Name = "${var.rds_identifier}-db-instance"
  }

}
