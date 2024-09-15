terraform {
  required_version = ">= 1.9.0"

  backend "s3" {
    bucket         = "rafb-terraform-backend"
    key            = "cliphub/staging.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "cliphub-tfstate-lock"
  }
}