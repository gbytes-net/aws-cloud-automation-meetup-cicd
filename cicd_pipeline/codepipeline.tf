resource "aws_s3_bucket" "build_cache" {
  bucket = "codepipeline-${var.application_name}-${var.branch}"
  acl = "private"
}

resource "aws_iam_role" "codepipeline" {
  name = "codepipeline-${var.application_name}-${var.branch}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "codepipeline-${var.application_name}-${var.branch}"
  role = aws_iam_role.codepipeline.id

  policy = file("${path.module}/codepipeline_iam_policy.json")
}

resource "aws_codepipeline" "this" {
  name = "${var.application_name}-${var.branch}"
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.build_cache.bucket
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      version = "1"
      output_artifacts = [
        "SourceArtifact"]

      configuration = {
        RepositoryName = var.repository_name
        BranchName = var.branch
        PollForSourceChanges = true
      }

      namespace = "SourceVariables"
    }
  }

  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = [
        "SourceArtifact"]
      output_artifacts = [
        "BuildArtifact"]
      version = "1"

      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }

      namespace = "BuildVariables"
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "CopyToS3"
      category = "Deploy"
      owner = "AWS"
      provider = "S3"
      input_artifacts = [
        "BuildArtifact"]
      version = "1"

      configuration = {
        BucketName = aws_s3_bucket.published_cicd_artifacts.bucket
        Extract = false

        ObjectKey = "${var.application_name}-{datetime}--#{SourceVariables.CommitId}.zip"
      }
    }
  }
}