terraform {
  backend "s3" {
    bucket         = "pooyan-terraform-state-bucket"
    key            = "terraform-aws-infra-modular/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}