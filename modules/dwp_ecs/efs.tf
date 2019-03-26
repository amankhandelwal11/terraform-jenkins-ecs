resource "aws_efs_file_system" "efs-jenkins" {
  creation_token = "efs-jenkins"

  tags = "${merge(local.common_tags,
            map("Name", "efs-jenkins")
          )}"
}

resource "aws_efs_mount_target" "efs-jenkins" {
  count = "${length(split(",", var.dwp_subnets))}"

  file_system_id = "${aws_efs_file_system.efs-jenkins.id}"
  subnet_id      = "${element(split(",", var.dwp_subnets), count.index)}"
}

output "mount-target-dns" {
  description = "Address of the mount target provisioned."
  value       = "${aws_efs_mount_target.efs-jenkins.0.dns_name}"
}
