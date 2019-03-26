output "EC2_LAMP_ELB" {
  value = "${module.dwp_ec2.load_balancer_dns_name}"
}

output "JENKINS_ELB" {
  value = "${module.dwp_ec2_reuse.load_balancer_dns_name}"
}
