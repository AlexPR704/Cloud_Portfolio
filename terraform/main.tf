resource "aws_dynamodb_table" "visitor_count" {
  name         = "VisitorCount"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "VisitorCountTable"
    Environment = "resume"
  }
}

resource "aws_s3_bucket" "resume_site" {
  bucket = "alexander-cloud-resume"
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "LambdaExecutionRole"
    Environment = "resume"
  }
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name = "lambda-dynamodb-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:UpdateItem",
          "dynamodb:GetItem"
        ]
        Resource = aws_dynamodb_table.visitor_count.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}

resource "aws_lambda_function" "visitor_counter" {
  function_name = "IncrementVisitorCount"
  runtime       = "python3.13"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"  # Adjust if your file or function is named differently

  s3_bucket = "alexander-cloud-resume"
  s3_key    = "lambda/lambda.zip"  # Make sure this matches the uploaded ZIP path

  source_code_hash = filebase64sha256("lambda.zip")

  timeout = 5

  tags = {
    Name        = "VisitorCounterLambda"
    Environment = "resume"
  }
}

resource "aws_apigatewayv2_api" "visitor_api" {
  name          = "VisitorCounterAPI"
  protocol_type = "HTTP"
}

