resource "aws_cognito_user_pool" "pool" {
  name                = "clips-user-pool-${var.stage}"
  deletion_protection = "ACTIVE"
}