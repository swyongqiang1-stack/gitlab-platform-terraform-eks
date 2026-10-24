output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public[*].id
}

output "private_subnet_app_id" {
  value = aws_subnet.private_app[*].id
}

output "private_subnet_db_id" {
  value = aws_subnet.private_db[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.gitlab.name
}