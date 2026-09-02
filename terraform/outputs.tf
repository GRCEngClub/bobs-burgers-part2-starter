output "bucket_name" {
  value = aws_s3_bucket.site.id
}

output "bucket_url" {
  value = "https://${aws_s3_bucket.site.bucket_regional_domain_name}"
}
