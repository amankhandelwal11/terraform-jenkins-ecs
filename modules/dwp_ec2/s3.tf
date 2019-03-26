resource "random_id" "dwp_code_bucket" {
  byte_length = 2
}

resource "aws_s3_bucket" "code" {
  bucket        = "${var.domain_name}-${random_id.dwp_code_bucket.dec}"
  acl           = "private"
  force_destroy = true

  tags = "${merge(local.common_tags,
            map("Name", "dwp_alb")
          )}"
}
