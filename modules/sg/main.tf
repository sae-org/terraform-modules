# ===============================================================
# SECURITY GROUP (covers both ALB and EC2 use cases)
# - Ingress rules: control who can reach this SG (e.g., Internet -> ALB, ALB -> EC2)
# - Egress rules:  control where instances/LB can go out to (default: all)
# ===============================================================

resource "aws_security_group" "sg" {
  name   = "${var.proj_prefix}-sg"   # Resource name shown in AWS console
  vpc_id = var.vpc_id                # VPC the SG belongs to

  # -------------------------------
  # INGRESS (ALLOW INBOUND)
  # -------------------------------
  # Build a list of ingress blocks from var.ingress_rules.
  # Each rule supports either cidr_blocks (e.g., 0.0.0.0/0) OR security_groups (SG-to-SG).
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol

      # Only set cidr_blocks if provided and non-empty (null removes the argument)
      cidr_blocks     = length(try(ingress.value.cidr_blocks, [])) > 0 ? ingress.value.cidr_blocks : null

      # Only set security_groups if provided and non-empty (SG referencing)
      security_groups = length(try(ingress.value.security_groups, [])) > 0 ? ingress.value.security_groups : null
    }
  }

  # -------------------------------
  # EGRESS (ALLOW OUTBOUND)
  # -------------------------------
  # Build a list of egress blocks from var.egress_rules.
  # Default below allows all egress (0.0.0.0/0, protocol -1).
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol

      # Only set cidr_blocks if provided and non-empty
      cidr_blocks     = length(try(egress.value.cidr_blocks, [])) > 0 ? egress.value.cidr_blocks : null

      # Only set security_groups if provided and non-empty (SG-to-SG)
      security_groups = length(try(egress.value.security_groups, [])) > 0 ? egress.value.security_groups : null
    }
  }

  # Helpful tag for quick identification
  tags = {
    Name = "${var.proj_prefix}-sg"
  }
}
