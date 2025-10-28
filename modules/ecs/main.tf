# Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.proj_prefix}-cluster"
}

# CloudWatch log group
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.proj_prefix}"
  retention_in_days = 30
}

# Task Definition (Fargate)
resource "aws_ecs_task_definition" "this" {
  family                   = var.proj_prefix
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = var.proj_prefix
      image     = var.image_uri
      essential = true

      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
        }
      ]

      environment = var.env_vars

      secrets = var.secret_vars

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "web"
        }
      }
    }
  ])
}

# Service
resource "aws_ecs_service" "this" {
  name            = "${var.proj_prefix}-svc"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  enable_ecs_managed_tags = true
  propagate_tags         = "SERVICE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.svc_sg_id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = var.proj_prefix
    container_port   = var.app_port
  }

  lifecycle {
    # Let CI/CD update only task_definition on deploy without TF churn
    ignore_changes = [task_definition, desired_count]
  }
}