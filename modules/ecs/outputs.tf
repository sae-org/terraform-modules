output "cluster_arn" {
  value = aws_ecs_cluster.this.arn 
}

output "cluster_name" { 
  value = aws_ecs_cluster.this.name 
}

output "service_arn" { 
  value = aws_ecs_service.this.arn 
}

output "service_name" { 
  value = aws_ecs_service.this.name 
}

output "task_definition_arn" { 
  value = aws_ecs_task_definition.this.arn 
}

output "log_group_name" { 
  value = aws_cloudwatch_log_group.ecs.name 
}
