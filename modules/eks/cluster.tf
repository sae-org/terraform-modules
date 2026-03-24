// - Create aws_eks_cluster (cluster control plane)
// - Create aws_eks_node_group resources for managed node groups (for_each)
resource "aws_eks_cluster" "this" {
	name     = var.cluster_name
	role_arn = var.cluster_iam_role_arn
	version  = var.kubernetes_version

	vpc_config {
		subnet_ids             = var.subnet_ids
		endpoint_public_access = var.endpoint_public_access
		public_access_cidrs    = var.public_access_cidrs
	}

	tags = var.tags
}

// Create managed node groups from the map provided in var.node_groups
resource "aws_eks_node_group" "this" {
	for_each = var.node_groups

	cluster_name    = aws_eks_cluster.this.name
	node_group_name = each.key

	# prefer per-node-group override, fallback to module-level node_role_arn
	node_role_arn = lookup(each.value, "node_role_arn", var.node_role_arn)

	subnet_ids = lookup(each.value, "subnet_ids", var.subnet_ids)

	scaling_config {
		desired_size = each.value.desired_size
		max_size     = each.value.max_size
		min_size     = each.value.min_size
	}

	instance_types = each.value.instance_types
	disk_size      = lookup(each.value, "disk_size", 20)

	dynamic "remote_access" {
		for_each = lookup(each.value, "ssh_key_name", null) == null ? [] : [1]
		content {
			ec2_ssh_key = lookup(each.value, "ssh_key_name", null)
		}
	}

	tags = merge(var.tags, lookup(each.value, "tags", {}))
}

// Expose useful data about the cluster via data sources (useful for kubeconfig generation)
data "aws_eks_cluster" "this" {
	name = aws_eks_cluster.this.name
}

data "aws_eks_cluster_auth" "this" {
	name = aws_eks_cluster.this.name
}

// NOTE: This module intentionally does not create IAM policies/IRSA roles.
// Create those in your `modules/iam` and pass role ARNs into helm values when you deploy addons.

