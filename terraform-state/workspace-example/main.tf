terraform {
	required_version = ">= 1.0.0, < 2.0.0"
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 4.0"
		}
	}
	backend "s3" {
		# 이전에 생성한 버킷 이름으로 변경
		bucket = "aws17-terraform-state"
		key = "workspace-example/terraform.tfstate"
		region = "ap-northeast-2"
		# 이전에 생성한 다이나모DB 테이블 이름으로 변경
		dynamodb_table = "aws17-terraform-locks"
		encrypt = true
	}
}
provider "aws" {
	region = "ap-northeast-2"
}
resource "aws_instance" "example" {
	ami = "ami-0ab04b3ccbadfae1f"
	instance_type = "t2.micro"
	# tags 추가
	tags = {
		Name = "aws17-example1"
	}
}

