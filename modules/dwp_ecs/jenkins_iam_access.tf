resource "aws_iam_user" "jenkins_ecs" {
  name = "jenkins_ecs"

  tags = "${merge(local.common_tags,
            map("Name", "jenkins_ecs")
          )}"
}

resource "aws_iam_access_key" "jenkins_ecs_key" {
  user = "${aws_iam_user.jenkins_ecs.name}"
}

resource "aws_iam_user_policy" "jenkins_ecs_rw" {
  name = "jenkins_ecs_rw"
  user = "${aws_iam_user.jenkins_ecs.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
