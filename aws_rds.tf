resource "aws_db_instance" "gitlab" {

  identifier     = "gitlab-postgres"
  engine         = "postgres"
  engine_version = "17"
  db_name        = "gitlabhq_production"

  instance_class = "db.t4g.medium"

  allocated_storage     = 30
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.gitlab.name
  vpc_security_group_ids = aws_security_group.rds.id

  publicly_accessible = false
  port                = 5432

  username                    = "gitlabadmin"
  manage_master_user_password = true

  multi_az = true

  backup_retention_period  = 7
  deletion_protection      = true
  skip_final_snapshot      = false
  final_snapshot_identifier = "gitlab-postgres-final-001"

  apply_immediately = false

  tags = {
    Component = "database"
  }
}