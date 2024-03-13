data "aws_caller_identity" "current" {}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_task_definition" "service" {
  family                   = var.service_name
  cpu                      = var.service_cpu
  memory                   = var.service_memory_hard_limit
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<EOF
[
  {
    "name": "${var.service_name}",
    "image": "${var.service_image}",
    "cpu": ${var.service_cpu},
    "memory": ${var.service_memory_hard_limit},
    "memoryReservation": ${var.service_memory_reservation},
    "environment": ${var.service_environment},
    "secrets": [
      {
        "name": "APP_PORT",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/APP_PORT"
      },
      {
        "name": "PROD_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/PROD_URL"
      },
      {
        "name": "DATABASE_HOST",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/DATABASE_HOST"
      },
      {
        "name": "DATABASE_NAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/DATABASE_NAME"
      },
      {
        "name": "DATABASE_PASSWORD",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/DATABASE_PASSWORD"
      },
      {
        "name": "DATABASE_PORT",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/DATABASE_PORT"
      },
      {
        "name": "DATABASE_USERNAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/DATABASE_USERNAME"
      },
      {
        "name": "S3_BUCKET_NAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/S3_BUCKET_NAME"
      },
      {
        "name": "AUTH0_AUDIENCE",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/AUTH0_AUDIENCE"
      },
      {
        "name": "AUTH0_DOMAIN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/AUTH0_DOMAIN"
      },
      {
        "name": "STRAPI_API",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/STRAPI_API"
      },
      {
        "name": "WEBHOOK_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/WEBHOOK_TOKEN"
      },
      {
        "name": "S3_ACCESS_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/S3_ACCESS_KEY"
      },
      {
        "name": "S3_ACCESS_SECRET",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/S3_ACCESS_SECRET"
      },
      {
        "name": "AUTH0_API_CLIENT_ID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/AUTH0_API_CLIENT_ID"
      },
      {
        "name": "AUTH0_API_CLIENT_SECRET",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/AUTH0_API_CLIENT_SECRET"
      },
      {
        "name": "SENDGRID_API_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/SENDGRID_API_KEY"
      },
      {
        "name": "SNS_PLATFORM_ARN_FCM",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/SNS_PLATFORM_ARN_FCM"
      },
      {
        "name": "CDN_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CDN_URL"
      },
      {
        "name": "ALGOLIA_APP_ID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ALGOLIA_APP_ID"
      },
      {
        "name": "ALGOLIA_API_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ALGOLIA_API_KEY"
      },
      {
        "name": "MANDRILL_API_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MANDRILL_API_KEY"
      },
      {
        "name": "MAILCHIMP_API_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MAILCHIMP_API_KEY"
      },
      {
        "name": "RD_STATION_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/RD_STATION_URL"
      },
      {
        "name": "RD_STATION_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/RD_STATION_TOKEN"
      },
      {
        "name": "TEAMS_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TEAMS_URL"
      },
      {
        "name": "TEAMS_URLALERT",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TEAMS_URLALERT"
      },
      {
        "name": "ZOOM_APIKEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ZOOM_APIKEY"
      },
      {
        "name": "ZOOM_APISECRET",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ZOOM_APISECRET"
      },
      {
        "name": "TEAMS_URL_RESPONSE",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TEAMS_URL_RESPONSE"
      },
      {
        "name": "ONESIGNAL_APIID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ONESIGNAL_APIID"
      },
      {
        "name": "ONESIGNAL_APIKEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ONESIGNAL_APIKEY"
      },
      {
        "name": "ONESIGNAL_APIURL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/ONESIGNAL_APIURL"
      },
      {
        "name": "VIMEO_CLIENT_IDENTIFIER",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/VIMEO_CLIENT_IDENTIFIER"
      },
      {
        "name": "VIMEO_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/VIMEO_TOKEN"
      },
      {
        "name": "CLIENT_SECRET",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CLIENT_SECRET"
      },
      {
        "name": "CUSTOMERIO_SITE_ID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CUSTOMERIO_SITE_ID"
      },
      {
        "name": "CUSTOMERIO_API_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CUSTOMERIO_API_KEY"
      },
      {
        "name": "CUSTOMERIO_API_KEY_APP",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CUSTOMERIO_API_KEY_APP"
      },
      {
        "name": "MEDSTREAM_URL_AUTH",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MEDSTREAM_URL_AUTH"
      },
      {
        "name": "MEDSTREAM_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MEDSTREAM_URL"
      },
      {
        "name": "MEDSTREAM_USERNAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MEDSTREAM_USERNAME"
      },
      {
        "name": "MEDSTREAM_PASSWORD",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MEDSTREAM_PASSWORD"
      },
      {
        "name": "MEDSTREAM_CLIENTID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MEDSTREAM_CLIENTID"
      },
      {
        "name": "MEDSTREAM_TARGET",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/MEDSTREAM_TARGET"
      },
      {
        "name": "TWILIO_ACCOUNT_ID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TWILIO_ACCOUNT_ID"
      },
      {
        "name": "TWILIO_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TWILIO_TOKEN"
      },
      {
        "name": "TWILIO_PHONE",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TWILIO_PHONE"
      },
      {
        "name": "CINCOPA_API_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CINCOPA_API_TOKEN"
      },
      {
        "name": "CINCOPA_API_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CINCOPA_API_URL"
      },
      {
        "name": "CLOUDINARY_CLOUD_NAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CLOUDINARY_CLOUD_NAME"
      },
      {
        "name": "CLOUDINARY_API_KEY",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CLOUDINARY_API_KEY"
      },
      {
        "name": "CLOUDINARY_API_SECRET",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CLOUDINARY_API_SECRET"
      },
      {
        "name": "AWS_BUCKET_NAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/AWS_BUCKET_NAME"
      },
      {
        "name": "TYPEFORM_ACCESS_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TYPEFORM_ACCESS_TOKEN"
      },
      {
        "name": "TYPEFORM_API_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/TYPEFORM_API_URL"
      },
      {
        "name": "USER_VALIDATION_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/USER_VALIDATION_URL"
      },
      {
        "name": "USER_VALIDATION_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/USER_VALIDATION_TOKEN"
      },
      {
        "name": "SISPRO_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/SISPRO_URL"
      },
      {
        "name": "CINCOPA_ANALYTICS_API_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CINCOPA_ANALYTICS_API_URL"
      },
      {
        "name": "CINCOPA_MAIN_ACCOUNT_UID",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CINCOPA_MAIN_ACCOUNT_UID"
      },
      {
        "name": "CHAT_DATABASE_NAME",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CHAT_DATABASE_NAME"
      },
      {
        "name": "CUSTOMERIO_API_URL",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CUSTOMERIO_API_URL"
      },
      {
        "name": "CUSTOMERIO_API_TOKEN",
        "valueFrom": "arn:aws:ssm:sa-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.environment_name}/CUSTOMERIO_API_TOKEN"
      }
    ],
    "essential": true,
    "mountPoints": [],
    "networkMode": "awsvpc",
    "portMappings": [{
      "containerPort": ${var.service_port}
    }],
    "dockerLabels": {
      "service": "${var.service_name}"
    },
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.service_name}",
        "awslogs-region": "sa-east-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "service" {
  name                  = var.service_name
  cluster               = var.ecs_cluster_id
  task_definition       = aws_ecs_task_definition.service.arn
  desired_count         = var.service_desired_count
  launch_type           = "FARGATE"
  wait_for_steady_state = true

  network_configuration {
    security_groups = var.security_groups
    subnets         = var.subnets
  }

  service_registries {
    registry_arn = aws_service_discovery_service.fargate.arn
    port         = var.service_port
  }

  # tasks are registered at the load balancer with their randomly chosen port mapped to the port of the application running inside the container
  load_balancer {
    target_group_arn = aws_alb_target_group.nest_api.arn
    container_name   = var.service_name
    container_port   = var.service_port
  }

  # a maximum of desired_count * 2 tasks will be started during a deployment
  deployment_maximum_percent = 200

  # minimum number of tasks during a deployment = desired_count
  deployment_minimum_healthy_percent = 100
}

resource "aws_cloudwatch_log_group" "logs" {
  name = var.service_name

  tags = {
    environment = var.environment_name
  }
}
