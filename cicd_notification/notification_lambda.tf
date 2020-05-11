
variable "lambda_file" {
  type = string
  default = "notification_lambda.py"
}

variable "lambda_zip_file" {
  type = string
  default = "notification_lambda.zip"
}

data "archive_file" "this" {
  type = "zip"

  source_file = "${path.module}/${var.lambda_file}"
  output_path = "${path.module}/${var.lambda_zip_file}"
}

resource "aws_iam_role" "lambda" {
  name = var.name

  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "this" {
  filename      = "${path.module}/${var.lambda_zip_file}"
  function_name = var.name
  role          = aws_iam_role.lambda.arn
  handler       = "notification_lambda.send_message"

  source_code_hash = filebase64sha256("${path.module}/${var.lambda_zip_file}")

  runtime = "python3.7"

  environment {
    variables = {
      DEBUG = "false"
      SLACK_URL = var.slack_url
      EMAIL_TOPIC_ARN = aws_sns_topic.this.arn
      MESSAGE = var.message
      SUBJECT = var.subject
    }
  }

  depends_on = [data.archive_file.this]
}

