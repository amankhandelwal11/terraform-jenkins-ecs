resource "aws_autoscaling_group" "dwp_asg" {
  name                      = "asg-${aws_launch_configuration.dwp_lc.id}"
  max_size                  = "${var.asg_max}"
  min_size                  = "${var.asg_min}"
  health_check_grace_period = "${var.asg_grace}"
  health_check_type         = "${var.asg_hct}"
  desired_capacity          = "${var.asg_cap}"
  force_delete              = true

  #load_balancers            = ["${aws_elb.dwp_elb.id}"]
  #load_balancers            = ["${aws_lb.dwp_alb.name}"]
  target_group_arns = ["${aws_alb_target_group.dwp_target.arn}"]

  vpc_zone_identifier = ["${var.dwp_subnets}"]

  launch_configuration = "${aws_launch_configuration.dwp_lc.name}"

  tags = "${list(zipmap(list("key", "value", "propagate_at_launch"), list("Name", "dwp_asg","true")), zipmap(list("key", "value", "propagate_at_launch"), list("Project", "DWP","true")), zipmap(list("key", "value", "propagate_at_launch"), list("Owner", "Kamarasu Alagarsamy","true")))}"

  lifecycle {
    create_before_destroy = true
  }
}
