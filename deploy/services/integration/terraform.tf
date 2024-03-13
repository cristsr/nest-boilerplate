terraform {
  backend "s3" {
    bucket         = "terraform-drs92ow7c8sr"
    key            = "test/integration/nest_api_service"
    region         = "sa-east-1"
    profile        = "test"
    dynamodb_table = "TerraformBackendLocks"
    role_arn       = "arn:aws:iam::902127070362:role/tf-iam-role-terraform"
  }
}
