resource "aws_lb_listener" "dwp_listener" {
  load_balancer_arn = "${aws_lb.dwp_alb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.dwp_target.id}"
  }
}
