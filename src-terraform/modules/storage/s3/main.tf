resource "aws_s3_bucket" "s3_default" {
  bucket = "s3-ecs-julio134"
}

# resource "aws_s3_bucket" "origin_bucket" {
#   bucket        = "my-cloudfront-origin-bucket-julio134"
#   force_destroy = true

#   website {
#     index_document = "index.html"
#     error_document = "error.html"
#   }
# }

# resource "aws_s3_bucket_policy" "origin_policy" {
#   bucket = aws_s3_bucket.origin_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action    = "s3:GetObject",
#         Effect    = "Allow",
#         Resource  = "${aws_s3_bucket.origin_bucket.arn}/*",
#         Principal = "*"
#       }
#     ]
#   })
# }

# resource "aws_s3_bucket_acl" "public" {
#     bucket = aws_s3_bucket.origin_bucket
#     acl = "public"

#     depends_on = [ aws_s3_bucket.origin_bucket ]
# }
