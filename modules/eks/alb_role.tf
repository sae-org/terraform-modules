data "http" "aws_lb_controller_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
}

module "alb_iam" {
  source   = "git::https://github.com/sae-org/terraform-modules.git//modules/iam?ref=main"
  proj_prefix = "eks-alb-controller-dev"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = data.terraform_remote_state.eks_oidc.outputs.oidc.oidc_arn
        }
        Condition = {
          StringEquals = {
            # restrict to the specific service account: kube-system/aws-load-balancer-controller
            "${replace(data.terraform_remote_state.eks_oidc.outputs.oidc.issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })

  create_profile = false
  role_policy = data.http.aws_lb_controller_iam_policy.response_body
}

resource "aws_eks_pod_identity_association" "alb_controller_association" {
  cluster_name = aws_eks_cluster.this.name
  namespace = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn     = module.alb_iam.role_arn
}

resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.this.name
  }

  set {
    name  = "region"
    value = "us-east-1"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  depends_on = [aws_eks_pod_identity_association.alb_controller_association]

}