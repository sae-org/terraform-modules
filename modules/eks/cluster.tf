// - Create aws_eks_cluster (cluster control plane)
// - Create aws_eks_node_group resources for managed node groups (for_each)

resource "aws_eks_cluster" "this" {
	name     = "eks-${var.proj_prefix}-cluster-${var.env}"
	role_arn = module.cluster_iam.role_arn
	version  = var.kubernetes_version

	vpc_config {
		subnet_ids             = var.pri_subnet_ids
		endpoint_public_access = var.endpoint_public_access
	}

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

	depends_on = [module.cluster_iam]
	
  tags = {
    Name = "${var.env}-eks-cluster"
  }
}


