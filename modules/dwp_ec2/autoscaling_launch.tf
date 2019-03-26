data "template_file" "init" {
  template = "${var.user_data_file}"

  vars = {
    efs_mount_target = "${var.efs_mount_target}"
    ecs_cluster      = "${var.ecs_cluster}"
    ecr_jenkins      = "${var.ecr_jenkins}"
    image_name       = "${var.image_name}"
    s3_bucket_code   = "${aws_s3_bucket.code.id}"
    jenkins_access_key_id = "${var.jenkins_access_key_id}"
    jenkins_access_key_secret = "${var.jenkins_access_key_secret}"
  }
}

resource "aws_launch_configuration" "dwp_lc" {
  name_prefix = "dwp_lc-"

  #image_id             = "${aws_ami_from_instance.dwp_golden.id}"
  image_id             = "${var.amazon_linux2_ami}"
  instance_type        = "${var.lc_instance_type}"
  iam_instance_profile = "${var.ecs-instance-profile}"

  security_groups = ["${aws_security_group.dwp_sg.id}"]
  key_name        = "${aws_key_pair.dwp_key_pair.id}"

  #user_data = "${var.user_data_file}"
  user_data = "${data.template_file.init.rendered}"

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "aws s3 sync files/ s3://${aws_s3_bucket.code.id}"
  }
}
