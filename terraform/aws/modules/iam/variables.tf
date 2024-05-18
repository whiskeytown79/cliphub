variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "table_name" {
  description = "The DynamoDB table name used for IAM policy creation."
  type        = string
}