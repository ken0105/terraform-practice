resource "aws_s3_bucket" "alb_log" {
  bucket = "alb-log-43fds4"
  acl = "private"

  lifecycle_rule {
    enabled = true
    expiration {
      days = 180
    }
  }

  tags = {
    Name = "alb_log"
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect = "Allow"
    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      identifiers = [582318560864]
      type = "AWS"
    }
  }
}