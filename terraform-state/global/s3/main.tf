terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "aws17-terraform-state"

#실수로 s3 버켓을 삭제하는 것을 방지한다.
  
#  lifecycle {
#    prevent_destroy = false
#  }

#삭제 허용
  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true

# 코드 이력을 관리하기 위해 상태 파일의 버전 관리를 활성화한다.
  versioning {
    enabled = true
  }
  
# 서버측 암호화를 활성화한다.
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name = "aws17-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
