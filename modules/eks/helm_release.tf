# AWS Load Balancer Controller Helm Release
resource "helm_release" "lbc_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  timeout = 600
  wait    = true
  atomic  = true

  set = [
    { 
      name = "clusterName"
      value = aws_eks_cluster.this.name 
    },
    { 
      name = "region"
      value = "us-east-1" 
    },
    { 
      name = "serviceAccount.create"
      value = "false" 
    },
    { 
      name = "serviceAccount.name"
      value = "aws-load-balancer-controller" 
    }

  ]

  # Ensure Helm waits for the Kubernetes service account to exist
  depends_on = [kubernetes_service_account_v1.lbc]
}


# ExternalDNS Helm Release
resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = "kube-system"

  set = [
    { 
      name = "provider"
      value = "aws" 
    },
    { 
      name = "aws.zoneType"
      value = "public" 
    },
    { 
      name = "serviceAccount.create"
      value = "false" 
    },
    { 
      name = "serviceAccount.name"
      value = "external-dns" 
    }

  ]

  depends_on = [
    kubernetes_service_account_v1.external_dns,
    helm_release.lbc_controller
  ]
}