# -------------------------------
# ALB LISTENERS
# -------------------------------

# A listener defines how the load balancer accepts traffic (ports/protocols)
# and what actions to take (redirect, forward, etc.)
resource "aws_lb_listener" "alb_listeners" {
  # Loop over all provided ports in var.ports
  for_each = {
    for p in var.ports : tostring(p.port) => p
  }

  # Attach the listener to the created ALB
  load_balancer_arn = aws_lb.alb.arn
  port              = each.value.port
  protocol          = each.value.protocol

  # Only HTTPS listeners use a certificate; HTTP doesn't need one
  certificate_arn = lower(each.value.protocol) == "https" ? data.terraform_remote_state.acm.outputs.certificate_arns[var.cert_name] : null

  # Listener default actions:
  # - If port == 80 (HTTP): redirect all traffic to HTTPS (port 443)
  # - If port == 443 (HTTPS): forward traffic to the target group
  dynamic "default_action" {
    for_each = [each.value]
    content {
      type = default_action.value.port == 80 ? "redirect" : "forward"

      # 1️⃣ Redirect HTTP (80) → HTTPS (443)
      dynamic "redirect" {
        for_each = default_action.value.port == 80 ? [1] : []
        content {
          port        = "443"
          protocol    = "HTTPS"
          status_code = var.http_status_code  # e.g., HTTP_301 for permanent redirect
        }
      }

      # 2️⃣ Forward HTTPS traffic → Target group (application)
      dynamic "forward" {
        for_each = default_action.value.port != 80 ? [1] : []
        content {
          target_group {
            # Forwards to the TG created for port 80 (application port)
            arn = aws_lb_target_group.tg["80"].arn
          }
        }
      }
    }
  }
}