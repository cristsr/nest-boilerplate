data "terraform_remote_state" "docred" {
  backend = "s3"

  config = {
    bucket   = "terraform-drs92ow7c8sr"
    key      = "test/main"
    region   = "sa-east-1"
    profile  = "docred"
    role_arn = "arn:aws:iam::902127070362:role/tf-iam-role-terraform"
  }
}
