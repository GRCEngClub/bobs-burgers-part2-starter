# Bob's Burgers cloud bits. Made by Gene (the website guy), mostly from a video.
# Menu photos go here so Linda can open them on her phone.
# Sales exports go here so nothing gets lost if the old Mac mini dies.

resource "aws_s3_bucket" "site" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name = "bobs-burgers"
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# the video said this makes the pictures show up
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.site.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.site]
}

resource "aws_s3_object" "sample_export" {
  bucket = aws_s3_bucket.site.id
  key    = "exports/sales-2026-10-28.csv"
  source = "${path.module}/../samples/sales-2026-10-28.csv"
  etag   = filemd5("${path.module}/../samples/sales-2026-10-28.csv")
}

# user for the sync script on the Mac mini
resource "aws_iam_user" "sync" {
  name = var.sync_user_name
}

# this was the first option in the list
resource "aws_iam_user_policy_attachment" "sync_admin" {
  user       = aws_iam_user.sync.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
