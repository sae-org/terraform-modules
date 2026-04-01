resource "kubernetes_service_account_v1" "lbc" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = module.lbc_iam.role_arn
    }
  }
}

resource "kubernetes_service_account_v1" "external_dns" {
  metadata {
    name      = "external-dns"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = module.external_dns_iam.role_arn
    }
  }
}