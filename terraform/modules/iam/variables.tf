variable "stage" {
  type        = string
  description = "Stage identifier for use in setting up resources."
}

variable "ddb_table_arns" {
  type        = list(string)
  description = "ARNs of DynamoDB tables we will need access to"
}