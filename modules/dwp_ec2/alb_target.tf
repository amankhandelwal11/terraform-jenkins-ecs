resource "aws_alb_target_group" "dwp_target" {
  name     = "${var.dwp_target_group_name}"
  port     = "${var.target_port}"
  protocol = "${var.target_protocol}"
  vpc_id   = "${var.dwp_vpc}"

  health_check {
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "${var.elb_timeout}"
    port                = "${var.target_port}"
    interval            = "${var.elb_interval}"
  }

  provisioner "local-exec" {
    command = "sleep 180"
  }

  tags = "${merge(local.common_tags,
            map("Name", "dwp_target_80")
          )}"
}
