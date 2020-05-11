output "codepipeline-name" {
  value = aws_codepipeline.this.name
}

output "cicd-artifact-bucket-name" {
  value = aws_s3_bucket.published_artifacts.bucket
}