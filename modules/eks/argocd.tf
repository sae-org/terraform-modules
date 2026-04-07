resource "kubernetes_manifest" "my_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = var.argo_cd_app_name
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.argo_cd_app_repo_url
        targetRevision = var.argo_cd_app_repo_target_revision
        path           = var.argo_cd_app_repo_path
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
}