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

resource "aws_launch_configuration" "example" {
  image_id        = "ami-06eea3cd85e2db8ce"
  instance_type  = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
			  #!/bin/bash
			  echo "hello, World" > index.html
			  nohup busybox httpd -f -p ${var.server_port} &
			  EOF
 lifecycle {
   create_before_destroy = true
 }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier = data.aws_subnets.default.ids

#desired_capacity = 1
  min_size = 1
  max_size = 2

  tag {
    key                 = "Name"
    value               = "aws17-terraform-asg-example"
    propagate_at_launch = true
  }
}

#보안그룸 설정 8080포트 Open

resource "aws_security_group" "instance" {
  name = "aws17-terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
