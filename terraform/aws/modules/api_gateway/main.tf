resource "aws_api_gateway_rest_api" "api" {
  name = "TextAPI"
}

resource "aws_api_gateway_resource" "texts_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "texts"
}

resource "aws_api_gateway_method" "texts_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.texts_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "texts_post_lambda" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.texts_resource.id
  http_method = aws_api_gateway_method.texts_post.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = var.add_text_lambda_arn
}

resource "aws_api_gateway_method" "texts_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.texts_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "texts_get_lambda" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.texts_resource.id
  http_method = aws_api_gateway_method.texts_get.http_method
  integration_http_method = "GET"
  type = "AWS_PROXY"
  uri = var.list_texts_lambda_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
  depends_on = [
    aws_api_gateway_method.texts_post,
    aws_api_gateway_method.texts_get,
    aws_api_gateway_integration.texts_post_lambda,
    aws_api_gateway_integration.texts_get_lambda
  ]
}
