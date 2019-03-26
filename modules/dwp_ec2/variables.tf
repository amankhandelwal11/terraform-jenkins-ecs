locals {
  common_tags = "${map(
    "Project", "DWP",
    "Owner", "Kamarasu Alagarsamy"
  )}"
}

variable "localip" {}
variable "domain_name" {}
variable "dwp_vpc" {}
variable "dwp_vpc_cidr" {}
variable "dwp_custom_cidr" {}

variable "dwp_subnets" {
  type = "list"
}

variable "dwp_zones" {}
variable "listener_port" {}
variable "listener_protocol" {}
variable "target_port" {}
variable "target_protocol" {}
variable "elb_healthy_threshold" {}
variable "elb_unhealthy_threshold" {}
variable "elb_timeout" {}
variable "elb_interval" {}
variable "key_name" {}
variable "public_key_path" {}
variable "amazon_linux2_ami" {}
variable "lc_instance_type" {}
variable "asg_cap" {}
variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_hct" {}
variable "dwp_sg_name" {}
variable "dwp_alb_name" {}
variable "dwp_target_group_name" {}

variable "user_data_file" {}

variable "ecs-instance-profile" {
  default = ""
}

variable "efs_mount_target" {}
variable "ecs_cluster" {}
variable "ecr_jenkins" {}
variable "image_name" {}
variable "jenkins_folder" {}
variable "jenkins_access_key_secret" {
  default = ""
}
variable "jenkins_access_key_id" {
  default = ""
}
