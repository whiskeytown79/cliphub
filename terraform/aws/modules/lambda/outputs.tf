output "add_text_lambda_invoke_arn" {
  value = aws_lambda_function.add_text.invoke_arn
}

output "list_texts_lambda_invoke_arn" {
  value = aws_lambda_function.list_texts.invoke_arn
}

output "add_text_code_s3_key" {
  value = aws_lambda_function.add_text.s3_key
}

output "list_texts_code_s3_key" {
  value = aws_lambda_function.list_texts.s3_key
}