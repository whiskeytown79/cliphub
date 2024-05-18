output "add_text_lambda_invoke_arn" {
  value = aws_lambda_function.add_text.invoke_arn
}

output "list_texts_lambda_invoke_arn" {
  value = aws_lambda_function.list_texts.invoke_arn
}