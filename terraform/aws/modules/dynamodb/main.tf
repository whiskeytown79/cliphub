resource "aws_dynamodb_table" "text_store" {
  name           = "TextStorePOC"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}