provider "aws" {
  region  = "sa-east-1"

  assume_role {
    role_arn = "arn:aws:iam::902127070362:role/tf-iam-role-terraform"
  }
}
