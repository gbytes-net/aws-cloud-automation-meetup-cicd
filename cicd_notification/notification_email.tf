
resource "aws_sns_topic" "this" {
  name = var.application_name
}

data "aws_iam_policy_document" "topic" {

  statement {
    actions = [
      "sns:Publish"
    ]

    effect = "Allow"

    resources = [
      aws_sns_topic.this.arn
    ]

    sid = "emailsnsid"
  }
}

resource "aws_iam_role_policy" "allow_lambda_to_publish_sns_topic" {
  policy = data.aws_iam_policy_document.topic.json
  role = aws_iam_role.lambda.id
}

