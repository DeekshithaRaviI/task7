output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = data.aws_ecr_repository.strapi.repository_url
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.strapi.name
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.postgres.endpoint
  sensitive   = true
}

output "strapi_admin_url" {
  description = "Strapi Admin URL"
  value       = "http://${aws_lb.main.dns_name}/admin"
}
