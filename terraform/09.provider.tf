terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61"
    }
    ansible = {
      source = "ansible/ansible"
      version = "~>1.1.0"
    }
  }
  backend "s3"{
    bucket          = "terraform-state-20240814004537765700000001"
    region          = "us-east-1"
    key             = "pin2.tfstate"
    dynamodb_table  = "terraform-state"
  }
}

provider "aws" {
  region  = var.AWS_DEFAULT_REGION
  profile = var.AWS_PROFILE
  default_tags {
    tags = {
      Enterprise  = var.enterprise,
      Project     = var.project_name,
      Environment = var.environment
    }
  }
}
