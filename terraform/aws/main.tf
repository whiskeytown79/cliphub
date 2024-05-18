terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3" {
  source = "./modules/s3"

  bucket_name = "cliphub-lambda-code"
  versioning  = true
  tags = {
    Environment = "production"
    Team        = "backend"
  }
}


module "dynamodb" {
  source = "./modules/dynamodb"
}

module "lambda" {
  source              = "./modules/lambda"
  table_name          = module.dynamodb.table_name
  lambda_iam_role_arn = module.iam.lambda_iam_role_arn
  lambda_function_add_text = {
    function_name = "AddText"
    handler       = "add_text.lambda_handler"
    runtime       = "python3.8"
    code_bucket   = module.s3.lambda_code_bucket_id
    code_key      = "AddText.zip"
  }
  lambda_function_list_texts = {
    function_name = "ListTexts"
    handler       = "list_texts.lambda_handler"
    runtime       = "python3.8"
    code_bucket   = module.s3.lambda_code_bucket_id
    code_key      = "ListTexts.zip"
  }
}

module "api_gateway" {
  source                = "./modules/api_gateway"
  add_text_lambda_arn   = module.lambda.add_text_lambda_invoke_arn
  list_texts_lambda_arn = module.lambda.list_texts_lambda_invoke_arn
}

module "iam" {
  source     = "./modules/iam"
  region     = var.region
  table_name = module.dynamodb.table_name
}