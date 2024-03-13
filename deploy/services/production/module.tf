locals {
  environment_name = "production"
  service_name     = "nest-api"
}


module "service" {
  source = "../../base/service"

  environment_name = local.environment_name

  ecs_cluster_id             = data.terraform_remote_state.docred.outputs.production.cluster_id
  service_name               = local.service_name
  service_desired_count      = 1
  service_image              = var.image
  service_cpu                = 1024
  service_memory_reservation = 2048
  service_memory_hard_limit  = 4096

  service_environment = <<EOF
[
  {"name": "APP_NAME", "value": "${local.service_name}"},
  {"name": "ENVIRONMENT_NAME", "value": "${local.environment_name}"},
  {"name": "LOG_LEVEL", "value": "warning"}
]
EOF

  service_log_type            = "ecs_text"
  service_port                = "8080"
  vpc_id                      = data.terraform_remote_state.docred.outputs.vpc.vpc_id
  alb_listener_arn            = data.terraform_remote_state.docred.outputs.alb.https_listener_arns[0]
  service_master_stage_domain = "test.com"
  security_groups             = [data.terraform_remote_state.docred.outputs.httpx_from_anywhere_id]
  subnets                     = data.terraform_remote_state.docred.outputs.vpc.private_subnets
  service_discovery_namespace = data.terraform_remote_state.docred.outputs.production.namespace
}