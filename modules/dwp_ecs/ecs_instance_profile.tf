resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "ecs-instance-profile"
  path = "/"
  role = "${aws_iam_role.ecs-instance-role.id}"

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

output "ecs-instance-profile-name" {
  value = "${aws_iam_instance_profile.ecs-instance-profile.name}"
}

output "ecs-instance-profile-id" {
  value = "${aws_iam_instance_profile.ecs-instance-profile.id}"
}
