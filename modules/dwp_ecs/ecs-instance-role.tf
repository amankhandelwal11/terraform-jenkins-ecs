#aws_iam_role - ecs-instance-role - AmazonEC2ContainerServiceforEC2Role

data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-instance-role" {
  name               = "ecs-instance-role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-instance-policy.json}"

  tags = "${merge(local.common_tags,
            map("Name", "ecs-instance-role")
          )}"
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = "${aws_iam_role.ecs-instance-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_policy" "ecr_access_policy" {
  name        = "ecr_access_policy"
  path        = "/"
  description = "ecr_access_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:*",
        "s3:*",
        "ecs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecr-instance-role-attachment" {
  role       = "${aws_iam_role.ecs-instance-role.name}"
  policy_arn = "${aws_iam_policy.ecr_access_policy.arn}"
}
