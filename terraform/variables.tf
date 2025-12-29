variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "strapi-ecs"
}

variable "container_port" {
  description = "Container port for Strapi"
  type        = number
  default     = 1337
}

variable "task_cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "512"
}

variable "task_memory" {
  description = "Memory for ECS task"
  type        = string
  default     = "1024"
}

variable "desired_count" {
  description = "Number of ECS task replicas"
  type        = number
  default     = 1
}

variable "aws_ecr_repo_name" {
  description = "Name of existing ECR repository"
  type        = string
  default     = "dee-strapi"
}

variable "ecs_execution_role_name" {
  description = "Name of existing ECS execution IAM role"
  type        = string
  default     = "strapi-ecs-ecs-execution-role"
}

variable "ecs_task_role_name" {
  description = "Name of existing ECS task IAM role"
  type        = string
  default     = "deek-strapi-ecs-task-role"
}

variable "database_client" {
  description = "Database client (sqlite, postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "database_host" {
  description = "Database host"
  type        = string
  default     = ""
}

variable "database_port" {
  description = "Database port"
  type        = string
  default     = "5432"
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "strapi"
}

variable "database_username" {
  description = "Database username"
  type        = string
  default     = "strapi"
}

variable "database_password" {
  description = "Database password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
  default     = "strapi-ecs-service"
}
