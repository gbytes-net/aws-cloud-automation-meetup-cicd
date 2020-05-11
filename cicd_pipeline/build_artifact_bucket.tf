resource "aws_s3_bucket" "published_artifacts" {
  # make sure bucket name is DNS compliant
  bucket = replace("published_artifacts_${var.application_name}_${var.branch}", "_", "-" )
  acl = "private"
}