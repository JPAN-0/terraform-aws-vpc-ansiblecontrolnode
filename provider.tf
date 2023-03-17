# Providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = var.s3_bucket
    region = var.aws_region
    key    = "terraform.tfstate"
  }  
}

# Providers

provider "aws" {
  region                    = var.aws_region
  access_key=var.aws_access_key
  secret_key=var.aws_secret_key
}
