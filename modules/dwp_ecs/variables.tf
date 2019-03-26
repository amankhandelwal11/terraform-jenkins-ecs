locals {
  common_tags = "${map(
    "Project", "DWP",
    "Owner", "Kamarasu Alagarsamy"
  )}"
}

variable "cluster_name" {}

#varibale "cluster_id" {}
variable "dwp_vpc" {}

variable "dwp_subnets" {}
variable "elb_healthy_threshold" {}
variable "elb_unhealthy_threshold" {}
variable "elb_timeout" {}
variable "elb_interval" {}
variable "dwp_ecs_alb_arn" {}
variable "dwp_ecs_alb_name" {}

variable "tagging_disabled" {
  default = "false"
}

variable "dwp_target_arn" {}
