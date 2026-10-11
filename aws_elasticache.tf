resource "aws_elasticache_replication_group" "gitlab" {
  replication_group_id = "gitlab-valkey"
  description          = "GitLab Valkey"

  engine         = "valkey"
  engine_version = "7.2"
  node_type      = "cache.t4g.small"
  port           = 6379

  cluster_mode       = "disabled"
  num_cache_clusters = 1

  subnet_group_name  = aws_elasticache_subnet_group.gitlab.name
  security_group_ids = aws_security_group.valkey.id

  parameter_group_name = aws_elasticache_parameter_group.gitlab.name

  transit_encryption_enabled = true
  at_rest_encryption_enabled = true

  automatic_failover_enabled = true
  multi_az_enabled           = true

  snapshot_retention_limit = 3
  apply_immediately        = false

  tags = {
    Component = "cache"
  }
}





resource "aws_elasticache_parameter_group" "gitlab" {
  name   = "gitlab-valkey7"
  family = "valkey7"

  parameter {
    name  = "maxmemory-policy"
    value = "noeviction"
  }
}