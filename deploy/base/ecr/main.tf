data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

resource "aws_ecr_repository" "repository" {
  name = var.name

  image_scanning_configuration {
    scan_on_push = var.image_scanning_configuration
  }
  tags = {
    Terraform   = "true"
    environment = var.environment
  }
}
