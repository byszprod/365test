terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = var.common_tags
  }
}