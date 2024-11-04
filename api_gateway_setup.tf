
resource "aws_iam_role" "api_gateway_logging" {

  name = "${var.project_name}-api-gateway-logging"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "api_gateway_logging" {
  role       = aws_iam_role.api_gateway_logging.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_logging.arn
}