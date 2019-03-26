#DWP_EC2 variables

aws_region = "eu-west-1"
aws_profile = "default"
localip    = "0.0.0.0/0"
domain = "dwp-domain-1"
elb_healthy_threshold = "2"
elb_unhealthy_threshold = "2"
elb_timeout = "3"
elb_interval = "30"
lc_instance_type = "t2.micro"
asg_cap = "1"
asg_max = "3"
asg_min = "1"
asg_grace = "60"
asg_hct = "EC2"

#DWP_ECS variables
cluster_name = "dwp-cluster"
