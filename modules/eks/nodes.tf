// Create managed node groups from the map provided in var.node_groups
resource "aws_eks_node_group" "this" {
	cluster_name    = aws_eks_cluster.this.name
	node_group_name = "eks-${var.proj_prefix}-node-group-${var.env}"
	node_role_arn = module.node_iam.role_arn
	subnet_ids = data.terraform_remote_state.vpc.outputs.vpc.pri_sub_id
	scaling_config {
		desired_size = var.desired_size
		max_size     = var.max_size
		min_size     = var.min_size
	}
  update_config {
    max_unavailable = 1
  }

	depends_on = [module.node_iam]
  tags = {
    Name = "${var.env}-node-group"
  }
}
