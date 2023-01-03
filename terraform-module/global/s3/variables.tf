variable "bucket_name" {
  description = "The Name of S3 bucketMust be globally unique"
  type = string
  default = "aws17-terraform-state"
}

variable "table_name" {
  description = "The Name of S3 DynamoDB Must be unique in this AWS account"
  type = string
  default = "aws17-terraform-locks"
}
