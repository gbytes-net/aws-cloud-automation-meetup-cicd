output "codepipeline_name" {
  value = aws_codepipeline.this.name
}

output "cicd_artifact_bucket_name" {
  value = aws_s3_bucket.published_artifacts.bucket
}