terraform {
  #테라폼 버전 지정
  required_version = ">=1.0.0, < 2.0.0"

  #공급자 버전 지정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-06eea3cd85e2db8ce"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id, aws_security_group.ssh.id]

  user_data = <<-EOF
			  #!/bin/bash
			  echo "Hello, world" > index.html
			  nohup busybox httpd -f -p 8080 &
			  EOF
  tags = {
    Name = "aws17-terraform-example"
  }
}

#보안그룸 설정 8080포트 Open

resource "aws_security_group" "instance" {
  name = "aws17-terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name = "aws17-terraform-example-ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Pubilc IP Output
output "public-ip" {
  value       = aws_instance.example.public_ip
  description = "The Public IP of Instance"
}
