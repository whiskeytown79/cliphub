variable "lambda_iam_role_arn" {
  description = "The IAM role used for lambda"
  type = string
}

variable "table_name" {
  description = "The DynamoDB table name used for IAM policy creation."
  type        = string
}

# AddText API
variable "lambda_function_add_text" {
  description = "Lambda code configuration for the add text API"
  type = object({
    code_bucket   = string
    code_key      = string
    function_name = string
    handler       = string
    runtime       = string
  })
}

# ListTexts API
variable "lambda_function_list_texts" {
  description = "Lambda code configuration for the list texts API"
  type = object({
    code_bucket   = string
    code_key      = string
    function_name = string
    handler       = string
    runtime       = string
  })
}
