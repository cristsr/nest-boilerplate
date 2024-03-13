variable "ecs_cluster_id" {
}
variable "service_name" {
}
variable "service_desired_count" { # number of tasks = containers
}
variable "service_image" {
}
variable "service_cpu" { # 1 CPU core = 1024
  default = 8
}
variable "service_memory_reservation" { # soft limit (in MiB) of memory to reserve for the container
  default = 8
}
variable "service_memory_hard_limit" { # hard limit (in MiB) of memory to present to the container, if your container attempts to exceed the memory specified here, the container is killed
  default = 64
}
variable "service_log_type" { # ecs_text or ecs_json depending on the stdout/stderr output of the container
  default = "ecs_text"
}
variable "service_port" {
}

# example
# [
#  { "name" : "string", "value" : "string" },
#  { "name" : "string", "value" : "string" }
# ]
variable "service_environment" {
}
variable "environment_name" {
}
variable "vpc_id" {
}
variable "service_master_stage_domain" {
}
variable "alb_listener_arn" {
}
variable "security_groups" {}
variable "subnets" {}

