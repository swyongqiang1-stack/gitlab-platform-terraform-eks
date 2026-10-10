resource "aws_security_group" "rds" {
  name   = "gitlab-rds-sg"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name      = "gitlab-rds-sg"
    Component = "database"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432

  referenced_security_group_id = aws_eks_cluster.gitlab.vpc_config[0].cluster_security_group_id
}

