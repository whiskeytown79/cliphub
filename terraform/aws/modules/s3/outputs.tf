output "lambda_code_bucket_id" {
  description = "The ID of the bucket"
  value       = aws_s3_bucket.code_bucket.id
}

output "lambda_code_bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.code_bucket.arn
}
