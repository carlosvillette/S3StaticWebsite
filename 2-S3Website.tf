resource "aws_s3_bucket_website_configuration" "name" {
    bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }
  
}