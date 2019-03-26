variable "aws_region" {
  default = "eu-west-1"
}

variable "aws_profile" {
  default = "default"
}

variable "localip" {
  default = "0.0.0.0/0"
}

variable "domain_name" {
  default = "dwp"
}

data "aws_vpc" "dwp_vpc" {
  default = true
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = "${data.aws_vpc.dwp_vpc.id}"
}

data "aws_availability_zones" "available" {
  #vpc_id = "${data.aws_vpc.dwp_vpc.id}"
}

variable "elb_healthy_threshold" {
  default = "2"
}

variable "elb_unhealthy_threshold" {
  default = "2"
}

variable "elb_timeout" {
  default = "3"
}

variable "elb_interval" {
  default = "30"
}

variable "key_name" {
  default = "dwp_key_pair"
}

variable "public_key_path" {
  default = "/Users/kamkarthi/Documents/Notes/DWP/dwp_id_rsa.pub"
}

data "aws_ami" "amazon_linux2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["137112412989"]
}

variable "lc_instance_type" {
  default = "t2.micro"
}

variable "asg_cap" {}
variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_hct" {}

#ECS variables
variable "cluster_name" {
  default = "main"
}

#variable "ecs-instance-profile" {}

