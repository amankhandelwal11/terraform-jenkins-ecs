module "dwp_ec2" {
  source = "./dwp_ec2"

  localip                 = "${var.localip}"
  domain_name             = "${var.domain_name}"
  dwp_vpc                 = "${data.aws_vpc.dwp_vpc.id}"
  dwp_vpc_cidr            = "${data.aws_vpc.dwp_vpc.cidr_block}"
  dwp_custom_cidr         = "0.0.0.0/0"
  dwp_zones               = "${data.aws_availability_zones.available.names}"
  dwp_subnets             = "${flatten(data.aws_subnet_ids.subnet_ids.*.ids)}"
  listener_port           = 80
  listener_protocol       = "HTTP"
  target_port             = 80
  target_protocol         = "HTTP"
  elb_healthy_threshold   = "${var.elb_healthy_threshold}"
  elb_unhealthy_threshold = "${var.elb_unhealthy_threshold}"
  elb_timeout             = "${var.elb_timeout}"
  elb_interval            = "${var.elb_interval}"
  lc_instance_type        = "${var.lc_instance_type}"
  amazon_linux2_ami       = "${data.aws_ami.amazon_linux2_ami.id}"
  asg_cap                 = "${var.asg_cap}"
  asg_max                 = "${var.asg_max}"
  asg_min                 = "${var.asg_min}"
  asg_grace               = "${var.asg_grace}"
  asg_hct                 = "${var.asg_hct}"
  public_key_path         = "${var.public_key_path}"
  key_name                = "dwp_key_1"
  dwp_sg_name             = "dwp_sg_1"
  dwp_alb_name            = "dwp-alb-1"
  dwp_target_group_name   = "dwp-target-1"
  user_data_file          = "${file("${path.module}/files/setup-lamp.tpl")}"
  efs_mount_target        = "${module.dwp_ecs.mount-target-dns}"
  ecs_cluster             = "${module.dwp_ecs.dwp_ecs_cluster_name}"
  ecr_jenkins             = "${module.dwp_ecs.ecr_jenkins_repo_url}"
  image_name              = "jenkins"
  jenkins_folder          = "${path.module}/files/}"
}

module "dwp_ec2_reuse" {
  source = "./dwp_ec2"

  localip                 = "${var.localip}"
  domain_name             = "dwp-domain-2"
  dwp_vpc                 = "${data.aws_vpc.dwp_vpc.id}"
  dwp_vpc_cidr            = "${data.aws_vpc.dwp_vpc.cidr_block}"
  dwp_custom_cidr         = "0.0.0.0/0"
  dwp_zones               = "${data.aws_availability_zones.available.names}"
  dwp_subnets             = "${flatten(data.aws_subnet_ids.subnet_ids.*.ids)}"
  listener_port           = 80
  listener_protocol       = "HTTP"
  target_port             = 80
  target_protocol         = "HTTP"
  elb_healthy_threshold   = "${var.elb_healthy_threshold}"
  elb_unhealthy_threshold = "${var.elb_unhealthy_threshold}"
  elb_timeout             = "${var.elb_timeout}"
  elb_interval            = "${var.elb_interval}"
  lc_instance_type        = "${var.lc_instance_type}"
  #lc_instance_type        = "m4.large"
  amazon_linux2_ami       = "ami-0b8e62ddc09226d0a"                            #ECS AMI Image
  asg_cap                 = "1"
  asg_max                 = "3"
  asg_min                 = "1"
  asg_grace               = "${var.asg_grace}"
  asg_hct                 = "${var.asg_hct}"
  public_key_path         = "${var.public_key_path}"
  key_name                = "dwp_key_2"
  dwp_sg_name             = "dwp_sg_2"
  dwp_alb_name            = "dwp-alb-2"
  dwp_target_group_name   = "dwp-target-2"
  user_data_file          = "${file("${path.module}/files/ecs_config.tpl")}"
  ecs-instance-profile    = "${module.dwp_ecs.ecs-instance-profile-id}"
  efs_mount_target        = "${module.dwp_ecs.mount-target-dns}"
  ecs_cluster             = "${module.dwp_ecs.dwp_ecs_cluster_name}"
  ecr_jenkins             = "${module.dwp_ecs.ecr_jenkins_repo_url}"
  image_name              = "jenkins"
  jenkins_folder          = "${path.module}/files/}"
  jenkins_access_key_id   = "${module.dwp_ecs.jenkins_access_key_id}"
  jenkins_access_key_secret   = "${module.dwp_ecs.jenkins_access_key_secret}"
}


module "dwp_ecs" {
  source = "./dwp_ecs"

  cluster_name = "${var.cluster_name}"

  #cluster_id              = "${data.aws_ecs_cluster.dwp-ecs-cluster.id}"
  dwp_subnets             = "${join(",", data.aws_subnet_ids.subnet_ids.ids)}"
  dwp_vpc                 = "${data.aws_vpc.dwp_vpc.id}"
  dwp_ecs_alb_name        = "${module.dwp_ec2_reuse.load_balancer_dns_name}"
  dwp_ecs_alb_arn         = "${module.dwp_ec2_reuse.load_balancer_arn}"
  elb_healthy_threshold   = "${var.elb_healthy_threshold}"
  elb_unhealthy_threshold = "${var.elb_unhealthy_threshold}"
  elb_timeout             = "${var.elb_timeout}"
  elb_interval            = "${var.elb_interval}"
  tagging_disabled        = "true"
  dwp_target_arn          = "${module.dwp_ec2_reuse.dwp_target_arn}"
}
