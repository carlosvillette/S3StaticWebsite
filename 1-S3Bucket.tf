resource "aws_s3_bucket" "example" {
  bucket        = "villette-class5-hw-s3"
  force_destroy = true

  tags = {
    Name        = "HW"
    Environment = "Dev"
  }

}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "hot-brazilian-women.jpg"
  source = "images/hot-brazilian-women.jpg"


}

resource "aws_s3_object" "file" {
  for_each     = fileset(path.module, "content/**/*.{html,css,js}")
  bucket       = aws_s3_bucket.example.id
  key          = replace(each.value, "/^content//", "")
  source       = each.value
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
  etag         = filemd5(each.value)
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.example.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.example.id}/*"
        }
      ]
    }
  )
}
