terraform {
  backend "s3" {
    bucket         = "pnelsen-tf-state"
    dynamodb_table = "terraform-state"
    key            = "terraform.tfstate"
    region         = "us-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.4"
    }
  }

  required_version = "~> 1.12"
}
