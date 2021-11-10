data "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

data "aws_s3_bucket" "logs_bucket" {
  bucket = var.logs_bucket_name
}

data "aws_caller_identity" "current" {}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    origin_id   = "${var.repository_name}-${var.stage}"
    domain_name = data.aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_path = "/${var.stage}"

    s3_origin_config {
      origin_access_identity = var.cloudfront_access_identity_path
    }
  }

  default_root_object = "index.html"

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  dynamic "viewer_certificate" {
    for_each = [var.certificate_arn]
    content {
      acm_certificate_arn      = viewer_certificate.value
      minimum_protocol_version = "TLSv1.1_2016"
      ssl_support_method       = "sni-only"
    }
  }

  default_cache_behavior {
    min_ttl     = 0
    default_ttl = 600
    max_ttl     = 86400

    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.repository_name}-${var.stage}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern = "index.html"

    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0

    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.repository_name}-${var.stage}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      headers      = ["*"]

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = length(var.domains) > 1 ? var.domains : null

  logging_config {
    bucket = data.aws_s3_bucket.logs_bucket.bucket_regional_domain_name
    prefix = "AWSLogs/${data.aws_caller_identity.current.account_id}/CloudFront/${var.service_slug}/${var.stage}/"
  }

  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = false
}