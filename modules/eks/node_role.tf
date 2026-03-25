module "node_iam" {
  source   = "git::https://github.com/sae-org/terraform-modules.git//modules/iam?ref=main"
  proj_prefix = "eks-node-dev"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  create_profile = false
  policy_attachment = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy","arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
}