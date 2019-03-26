resource "aws_lb" "dwp_alb" {
  name               = "${var.dwp_alb_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.dwp_sg.id}"]
  subnets            = ["${var.dwp_subnets}"]

  enable_deletion_protection = false

  tags = "${merge(local.common_tags,
            map("Name", "dwp_alb")
          )}"
}
