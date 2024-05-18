# TODO: Change the repeated blocks to use a for_each consruct where the list of function
# configurations is passed in.

resource "aws_lambda_function" "add_text" {
  function_name = var.lambda_function_add_text.function_name # "AddText"
  handler       = var.lambda_function_add_text.handler # "add_text.lambda_handler"
  runtime       = var.lambda_function_add_text.runtime # "python3.8"
  role          = var.lambda_iam_role_arn

  s3_bucket = var.lambda_function_add_text.code_bucket
  s3_key    = var.lambda_function_add_text.code_key

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}

resource "aws_lambda_function" "list_texts" {
  function_name = var.lambda_function_list_texts.function_name # "ListTexts"
  handler       = var.lambda_function_list_texts.handler # "list_texts.lambda_handler"
  runtime       = var.lambda_function_list_texts.runtime # "python3.8"
  role          = var.lambda_iam_role_arn

  s3_bucket = var.lambda_function_list_texts.code_bucket
  s3_key    = var.lambda_function_list_texts.code_key

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}