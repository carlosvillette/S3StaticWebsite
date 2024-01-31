output "s3_url" {
  description = "S3 hosting URL (HTTP)"
  value       = "http://${aws_s3_bucket_website_configuration.name.website_endpoint}"
}