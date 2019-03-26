output "dwp_ecs_cluster_name" {
  value = "${aws_ecs_cluster.dwp-ecs-cluster.name}"
}

output "ecr_jenkins_repo_url" {
  value = "${aws_ecr_repository.jenkins.repository_url}"
}

output "ecr_jenkins_repo_registry_id" {
  value = "${aws_ecr_repository.jenkins.registry_id}"
}

output "ecr_jenkins_repo_arn" {
  value = "${aws_ecr_repository.jenkins.arn}"
}


output "jenkins_access_key_id" {
  value = "${aws_iam_access_key.jenkins_ecs_key.id}"
}

output "jenkins_access_key_secret" {
  value = "${aws_iam_access_key.jenkins_ecs_key.secret}"
}
