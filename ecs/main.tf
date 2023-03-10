resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.name}-execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-iam-role"
  })
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = lower("${var.name}-cluster")
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-ecs"
  })
}

#Log Group for container logs
resource "aws_cloudwatch_log_group" "log-group" {
  name              = "${var.name}-logs"
  retention_in_days = 7
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-ecs"
  })
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.name}-squid-proxy"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.name}-squid-proxy",
      "image": "${var.ecr_repository_url}:latest",
      "entryPoint": [],
      "environment": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "task"
        }
      },
      "portMappings": [
        {
          "containerPort": 3128,
          "hostPort": 3128
        }
      ],
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-ecs-task-definition"
  })
}


resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.name}-ecs-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = "${aws_ecs_task_definition.aws-ecs-task.family}:${max(aws_ecs_task_definition.aws-ecs-task.revision, data.aws_ecs_task_definition.main.revision)}"
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = false
    security_groups  = var.security_group_ids
  }
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name}-ecs-service"
  })

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.name}-squid-proxy"
    container_port   = 3128
  }
}

