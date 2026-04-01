# module "eks_oidc" {
#   source   = "git::https://github.com/sae-org/terraform-modules.git//modules/oidc?ref=main"
#   oidc_url                    = aws_eks_cluster.this.identity[0].oidc[0].issuer
#   client_id_list              = ["sts.amazonaws.com"]
# }