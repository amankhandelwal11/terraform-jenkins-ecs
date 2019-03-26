# Jenkins Service
resource "aws_ecs_service" "jenkins" {
  name            = "jenkins"
  cluster         = "${aws_ecs_cluster.dwp-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.jenkins.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs-service-role.arn}"

  #depends_on      = ["aws_iam_role_policy_attachment.ecs-service-attach"]

  load_balancer {
    target_group_arn = "${var.dwp_target_arn}"
    container_name   = "jenkins"
    container_port   = "8080"
  }
  lifecycle {
    ignore_changes = ["desired_count"]
  }
}

resource "aws_ecs_task_definition" "jenkins" {
  family = "jenkins"

  container_definitions = <<EOF
  [
    {
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 8080
        },
        {
          "hostPort": 50000,
          "protocol": "tcp",
          "containerPort": 50000
        }
      ],
      "cpu": 512,
      "memory": 512,
      "image": "${aws_ecr_repository.jenkins.repository_url}",
      "name": "jenkins",
      "hostname": "jenkins",
      "essential": true,
      "Volumes": [
        {
          "Name": "efs-jenkins",
          "Host": {
            "SourcePath": "/mnt/efs"
          }
        }
      ],
      "Environment": [
        {
          "Name": "JAVA_OPTS",
          "Value": "-Djenkins.install.runSetupWizard=false"
        }
      ],
      "MountPoints": [
        {
          "ContainerPath": "/var/jenkins_home",
          "SourceVolume": "efs-jenkins"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs-demo/jenkins",
            "awslogs-region": "eu-west-1",
            "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
EOF

  volume {
    name      = "efs-jenkins"
    host_path = "/mnt/efs"
  }
}

resource "aws_cloudwatch_log_group" "jenkins" {
  name = "/ecs-demo/jenkins"
}
