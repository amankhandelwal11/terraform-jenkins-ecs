# Terraform with AWS EC2, ECS and Jenkins

## Project Scope:

- setup EC2 instance using terraform module
- reuse the previous module to setup ECS instance for hosting Jenkins Master
- CI/CD pipeline

## Approach:

- Module [`dwp_ec2`] is written to setup LAMP stack with autoscaling group (ASG) on AWS EC2
- MOdule [`dwp_ecs`] will reuse the previous module to launch ASG instance on ECS cluster and setup Jenkins master as ECS cluster service
- Setup CI/CD pipeline to invoke automation from Jenkins master on the ECS cluster utilizing [`Amazon EC2 Container Service Plugin`](https://github.com/jenkinsci/amazon-ecs-plugin) and perform cntaineri'zed deployments


## To create complete stack:
```sh
git clone https://github.com/kamkarthi/terraform-jenkins-ecs.git terraform-jenkins-ecs.git
cd terraform-jenkins-ecs.git
terraform init
terraform plan
terrafom apply
```
## To destroy the stack:

```sh
terraform destroy
```

## Outputs:
At the end of the stack provisioning, outputs will be displayed for the ELB endpoint to acces the respective stacks.

ex: (please use the dns names shown on the screen output)

- `EC2_LAMP_ELB = dwp-alb-1-528138388.eu-west-1.elb.amazonaws.com`
- `JENKINS_ELB = dwp-alb-2-225829089.eu-west-1.elb.amazonaws.com`
