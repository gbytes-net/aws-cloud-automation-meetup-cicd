resource "aws_iam_role" "this" {
  name = "instance_${var.application_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Application = var.application_name
  }
}

data "aws_iam_policy_document" "this" {

  // allows logging to cloudwatch
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  // allows retrieval of artifacts from s3
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild" {
  role = aws_iam_role.this.name

  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_instance_profile" "this" {
  name = "instance_${var.application_name}_profile"
  role = aws_iam_role.this.name
}