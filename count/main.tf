provider "aws" {
  region = "ap-northeast-2"
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["aws17-alpa", "aws17-beta", "aws17-gamma"]
}
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

output "alpa_arn" {
  value = aws_iam_user.example[*].arn
}
