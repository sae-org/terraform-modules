# module "cluster_iam" {
#   source   = "git::https://github.com/sae-org/terraform-modules.git//modules/iam?ref=main"
#   proj_prefix = "eks-${var.proj_prefix}-cluster-${var.env}"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })
#   create_profile = false
#   policy_attachment = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
# }