/**
data "aws_vpc" "default" {
  default = "${var.vpc_id == "" ? true : false}"
  id      = "${var.vpc_id}"
}

data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_region" "current" {}
**/
