resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = var.cf_price_class
  comment         = "${var.proj_prefix} CDN"

  aliases = var.cf_aliases

  origin {
    domain_name = var.alb_dns_name
    origin_id   = "alb-origin"

    # ALB is a custom origin (not S3)
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"     # CloudFront -> ALB over HTTP
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # Optional: send a header you can match in ALB/WAF if you want an extra guard
    custom_header {
      name  = "X-From-CloudFront"
      value = "true"
    }
  }

  # ---------- Default behavior ----------
  default_cache_behavior {
    target_origin_id       = "alb-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    # Use managed policies instead of deprecated forwarded_values
    cache_policy_id            = data.aws_cloudfront_cache_policy.caching_optimized.id
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.all_viewer.id
  }

  # ---------- Static: cache aggressively ----------
  ordered_cache_behavior {
    path_pattern              = "/static/*"
    target_origin_id          = "alb-origin"
    viewer_protocol_policy    = "redirect-to-https"
    compress                  = true

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id          = data.aws_cloudfront_cache_policy.caching_optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id
  }

  # ---------- APIs: disable caching ----------
  ordered_cache_behavior {
    path_pattern              = "/api/*"
    target_origin_id          = "alb-origin"
    viewer_protocol_policy    = "redirect-to-https"
    compress                  = false

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id          = data.aws_cloudfront_cache_policy.caching_disabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id
  }

  # ---------- Logging (optional) ----------
  dynamic "logging_config" {
    for_each = var.cf_enable_logging && var.cf_log_bucket != null ? [1] : []
    content {
      bucket = var.cf_log_bucket
      include_cookies = false
      prefix = "${var.proj_prefix}/"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # ---------- Certificate handling ----------
  # If you supplied a cert ARN (for aliases)
  dynamic "viewer_certificate" {
    for_each = var.cf_certificate_arn != null ? [1] : []
    content {
      acm_certificate_arn      = var.cf_certificate_arn
      ssl_support_method       = "sni-only"
      minimum_protocol_version = "TLSv1.2_2021"
    }
  }

  # Else, use the default CloudFront certificate (*.cloudfront.net)
  dynamic "viewer_certificate" {
    for_each = var.cf_certificate_arn == null ? [1] : []
    content {
      cloudfront_default_certificate = true
      minimum_protocol_version       = "TLSv1.2_2021"
    }
  }

  tags = {
      Name    = "${var.proj_prefix}-cdn"
      Project = var.proj_prefix
  }

}
