# -----------------------------
# compute non-overlapping offsets for per-AZ subnets.

# az_count: number of AZs (length(var.vpc_az))
# public_offset: where public subnets start (1 skips the first /24)
# private_offset: starts right after the public subnets
# ------------------------------
locals {
  az_count       = length(var.vpc_az)
  public_offset  = 1           
  private_offset = local.public_offset + local.az_count
}