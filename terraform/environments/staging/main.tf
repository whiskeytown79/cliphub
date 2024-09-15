module "cognito" {
  source = "../../modules/cognito"
  stage  = local.stage
}

module "lambda" {
  source = "../../modules/lambda"
}

module "api_gateway" {
  source = "../../modules/api_gateway"
}

module "dynamodb" {
  source = "../../modules/dynamodb"
  stage  = local.stage
}

module "s3" {
  source = "../../modules/s3"
}

module "cloudfront" {
  source = "../../modules/cloudfront"
}

module "iam" {
  source         = "../../modules/iam"
  stage          = local.stage
  ddb_table_arns = [
    module.dynamodb.ddb_table_clips_arn
  ]
}