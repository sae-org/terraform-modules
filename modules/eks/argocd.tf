resource "kubernetes_manifest" "my_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = var.argo_cd_app_name
      namespace = var.argocd_namespace
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.repo_url
        targetRevision = var.repo_target_revision
        path           = var.repo_path
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
  depends_on = [helm_release.argo_cd]
}

# ================================
# ARGOCD REPOSITORY CREDENTIAL SECRET
# ================================
# This secret allows Argo CD to authenticate with private Git repositories.
# Argo CD automatically detects and uses secrets matching the repo URL.

data "aws_secretsmanager_secret_version" "secret" {
  secret_id     = var.secret_arn
  version_stage = var.secret_version_stage # get the active value 
}

locals {
  raw_secret     = data.aws_secretsmanager_secret_version.secret.secret_string
  decoded_secret = trimspace(jsondecode(local.raw_secret)[var.secret_key])
}

resource "kubernetes_secret" "argocd_repo" {
  metadata {
    name      = var.argo_secret_name
    namespace = var.argocd_namespace
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  data = {
    type     = "git"
    url      = var.repo_url
    username = var.github_username
    password = local.decoded_secret
  }
}