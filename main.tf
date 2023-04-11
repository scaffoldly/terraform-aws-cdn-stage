locals {
  domain                 = var.subdomain != "" ? (var.subdomain_suffix != "" ? "${var.subdomain}-${var.subdomain_suffix}.${var.root_domain}" : "${var.subdomain}.${var.root_domain}") : (var.subdomain_suffix != "" ? "${var.subdomain_suffix}.${var.root_domain}" : var.root_domain)
  disable_cache_patterns = length(var.disable_cache_patterns) != 0 ? var.disable_cache_patterns : ["/", "*.html", "*.json"]
}

data "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

data "aws_s3_bucket" "logs_bucket" {
  bucket = var.logs_bucket_name
}

data "aws_route53_zone" "zone" {
  count = var.root_domain != "" ? 1 : 0

  name = var.root_domain

  provider = aws.dns
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
    for_each = length(var.cdn_domains) > 0 ? [1] : []
    content {
      acm_certificate_arn      = var.certificate_arn
      minimum_protocol_version = "TLSv1.1_2016"
      ssl_support_method       = "sni-only"
    }
  }

  dynamic "viewer_certificate" {
    for_each = length(var.cdn_domains) > 0 ? [] : [1]
    content {
      cloudfront_default_certificate = true
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

    dynamic "lambda_function_association" {
      for_each = var.function_associations
      content {
        event_type = lambda_function_association.key
        lambda_arn = lambda_function_association.value.function_arn
      }
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = local.disable_cache_patterns
    content {
      path_pattern = ordered_cache_behavior.value

      min_ttl     = 0
      default_ttl = 0
      max_ttl     = 0

      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      target_origin_id       = "${var.repository_name}-${var.stage}"
      viewer_protocol_policy = "redirect-to-https"
      compress               = false

      forwarded_values {
        query_string = false

        cookies {
          forward = "none"
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = length(var.cdn_domains) > 0 ? [local.domain] : null

  logging_config {
    bucket = data.aws_s3_bucket.logs_bucket.bucket_regional_domain_name
    prefix = "AWSLogs/${data.aws_caller_identity.current.account_id}/CloudFront/${var.service_slug}/${var.stage}/"
  }

  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = false
}

resource "aws_route53_record" "record" {
  count = var.root_domain != "" && length(var.cdn_domains) > 0 ? 1 : 0

  name    = local.domain
  type    = "A"
  zone_id = data.aws_route53_zone.zone[0].zone_id

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }

  provider = aws.dns
}
