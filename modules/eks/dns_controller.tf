# module "external_dns_iam" {
#   source   = "git::https://github.com/sae-org/terraform-modules.git//modules/iam?ref=main"
#   proj_prefix = "eks-${var.proj_prefix}-external-dns-${var.env}"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Federated = module.eks_oidc.oidc_arn
#         }
#         Condition = {
#           StringEquals = {
#             # restrict to the specific service account: kube-system/aws-load-balancer-controller
#             "${replace(module.eks_oidc.oidc_url, "https://", "")}:sub" = "system:serviceaccount:kube-system:external-dns"
#           }
#         }
#       }
#     ]
#   })

#   create_profile = false

#   role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"                    # Allows modifying Route 53 records in all hosted zones
#         Action = [
#           "route53:ChangeResourceRecordSets",
#           "route53:ListResourceRecordSets",
#           "route53:ListTagsForResources",
#         ]
#         Resource = [
#           "arn:aws:route53:::hostedzone/*",
#         ]
#       },
#       {
#         Effect = "Allow"     # Allows listing all hosted zones (needed by ExternalDNS to find zones)
#         Action = [
#           "route53:ListHostedZones",
#         ]
#         Resource = [
#           "*",
#         ]
#       }
#     ]
#     })
# }