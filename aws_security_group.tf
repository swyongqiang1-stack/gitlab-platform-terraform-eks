resource "aws_security_group" "rds" {
  name   = "gitlab-rds-sg"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name      = "gitlab-rds-sg"
    Component = "security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432

  referenced_security_group_id = aws_eks_cluster.gitlab.vpc_config[0].cluster_security_group_id
}

resource "aws_security_group" "valkey" {
  name   = "gitlab-valkey-sg"
  vpc_id = module.vpc.vpc_id

  tags = {
    Component = "security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "valkey" {
  security_group_id = aws_security_group.valkey.id

  ip_protocol = "tcp"
  from_port   = 6379
  to_port     = 6379

  referenced_security_group_id = aws_eks_cluster.gitlab.vpc_config[0].cluster_security_group_id
}