resource "aws_service_discovery_service" "fargate" {
  name = "api"
  dns_config {
    namespace_id = var.service_discovery_namespace
    routing_policy = "MULTIVALUE"
    dns_records {
      ttl = 10
      type = "A"
    }

    dns_records {
      ttl  = 10
      type = "SRV"
    }
  }
  health_check_custom_config {
    failure_threshold = 5
  }
}

variable "service_discovery_namespace" {}

// TODO: change to use the correct domain name
output "discovery_dns" {
  value="api.${var.environment_name}.test.local"
}
