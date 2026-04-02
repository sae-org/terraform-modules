data "http" "aws_lb_controller_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
}

module "lbc_iam" {
  source   = "git::https://github.com/sae-org/terraform-modules.git//modules/iam?ref=main"
  proj_prefix = "eks-${var.proj_prefix}-lbc-controller-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = aws_iam_openid_connect_provider.this.arn
        }
        Condition = {
          StringEquals = {
            # restrict to the specific service account: kube-system/aws-load-balancer-controller
            "${replace(aws_iam_openid_connect_provider.this.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })

  create_profile = false
  role_policy = data.http.aws_lb_controller_iam_policy.response_body
}

