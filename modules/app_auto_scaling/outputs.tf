output "scalable_target_id" {
  value       = try(aws_appautoscaling_target.this[0].resource_id, null)
  description = "Registered scalable target resource_id"
}

output "cpu_policy_name" {
  value       = try(aws_appautoscaling_policy.cpu[0].name, null)
  description = "CPU policy name"
}

output "mem_policy_name" {
  value       = try(aws_appautoscaling_policy.mem[0].name, null)
  description = "Memory policy name"
}
