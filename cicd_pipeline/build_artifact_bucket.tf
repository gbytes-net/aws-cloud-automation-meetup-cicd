resource "aws_s3_bucket" "published_cicd_artifacts" {
  bucket = "cicd-artifacts-${var.application_name}-${var.branch}"
  acl = "private"
}