output "load_balancer_dns_name" {
  value = "${aws_lb.dwp_alb.dns_name}"
}

output "load_balancer_arn" {
  value = "${aws_lb.dwp_alb.arn}"
}

output "dwp_listener_arn" {
  value = "${aws_lb_listener.dwp_listener.arn}"
}

output "dwp_target_arn" {
  value = "${aws_alb_target_group.dwp_target.arn}"
}

output "s3_code_bucket" {
  value = "${aws_s3_bucket.code.id}"
}

/**
output "s3_access_role" {
  value = "${aws_iam_role.s3_access_role.id}"
}
**/

