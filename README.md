# Terraform with AWS EC2, ECS and Jenkins

## Project Scope:

- setup EC2 instance using terraform module
- reuse the previous module to setup ECS instance for hosting Jenkins Master
- CI/CD pipeline

## Approach:

- Module [`dwp_ec2`] is written to setup LAMP stack on AWS EC2 with autoscaling group (ASG)
- Module [`dwp_ecs`] will reuse the previous module to launch ASG instance on ECS cluster and setup Jenkins master as ECS cluster service
- Setup CI/CD pipeline to invoke automation from Jenkins master on the ECS cluster utilizing [`Amazon EC2 Container Service Plugin`](https://github.com/jenkinsci/amazon-ecs-plugin) and perform cntaineri'zed deployments

## Requirements
- recommended m4.large EC2 sizing
- terraform binary installed

## To create complete stack:
```sh
git clone https://github.com/kamkarthi/terraform-jenkins-ecs.git terraform-jenkins-ecs.git
cd terraform-jenkins-ecs.git/modules
terraform init
terraform plan
terrafom apply
```
NOTE: The deployment will take 15 mins for services to have accessible through ELB.
## To destroy the stack:

```sh
terraform destroy
```

## Outputs:
At the end of the [`terraform apply`], outputs will be displayed with ELB endpoint dns names to access corresponding stacks respectively.

ex: (please use the dns names shown on the screen output)

- `EC2_LAMP_ELB = dwp-alb-1-528138388.eu-west-1.elb.amazonaws.com`
- `JENKINS_ELB = dwp-alb-2-225829089.eu-west-1.elb.amazonaws.com`
