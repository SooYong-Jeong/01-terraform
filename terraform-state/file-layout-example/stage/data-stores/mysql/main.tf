terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "aws17-terraform-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "aws17-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "aws17-erraform-example"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true

  name     = var.db_name
  username = var.db_username
  password = var.db_password
}

