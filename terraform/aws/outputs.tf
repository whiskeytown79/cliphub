output "api_gateway_invoke_url" {
  value = module.api_gateway.invoke_url
}

output "lambda_zip_add_text" {
  value = module.lambda.add_text_code_s3_key
}

output "lambda_zip_list_texts" {
  value = module.lambda.list_texts_code_s3_key
}