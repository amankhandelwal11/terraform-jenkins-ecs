#!/bin/bash
echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
yum install -y nfs-utils aws-cli wget git

mkdir -p /mnt/efs
echo "${efs_mount_target}:/    /mnt/efs   nfs4    defaults" >> /etc/fstab
mount -a
chmod -R 777 /mnt/efs

eval "$(aws ecr get-login --region eu-west-1 --no-include-email)"
mkdir /tmp/build_docker_image
cd /tmp/build_docker_image
chown ec2-user /tmp/build_docker_image
aws s3 sync s3://${s3_bucket_code}/jenkins jenkins

awk -v ACCESSKEY="${jenkins_access_key_id}" '/<accessKey>/ {f=1} !f; /<\/accessKey>/ {f=0; print "          <accessKey>"ACCESSKEY"</accessKey>"}' < jenkins/credentials.xml > jenkins/credentials1.xml
awk -v ACCESSKEY="${jenkins_access_key_secret}" '/<secretKey>/ {f=1} !f; /<\/secretKey>/ {f=0; print "          <secretKey>"ACCESSKEY"</secretKey>"}' < jenkins/credentials1.xml > jenkins/credentials.xml
awk -v hostname=http://"$(hostname -f)" '/<jenkinsUrl>/ {f=1} !f; /<\/jenkinsUrl>/ {f=0; print "      <jenkinsUrl>"hostname"</jenkinsUrl>"}' < jenkins/config.xml > jenkins/config1.xml
awk -v clusterArn="$(aws ecs describe-clusters --clusters dwp-ecs-cluster --region eu-west-1 --query clusters[0].clusterArn |sed 's/\"//g')" '/<cluster>/ {f=1} !f; /<\/cluster>/ {f=0; print "      <cluster>"clusterArn"</cluster>"}' < jenkins/config1.xml > jenkins/config.xml

cp jenkins/credentials.xml /mnt/efs/

cat <<EOF>> Dockerfile
FROM jenkins/jenkins:2.164.1

COPY jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# Jenkins settings
COPY jenkins/config.xml /usr/share/jenkins/ref/config.xml.override
COPY jenkins/credentials.xml /usr/share/jenkins/ref/credentials.xml.override

#Create simple java appa pipeline
RUN mkdir -p /usr/share/jenkins/ref/jobs/simple-java-maven-app/
COPY jenkins/simple-java-maven-app-config.xml /usr/share/jenkins/ref/jobs/simple-java-maven-app/config.xml
EOF

docker build -t ${image_name} .
docker tag ${image_name}:latest ${ecr_jenkins}:latest
docker push ${ecr_jenkins}:latest
#docker rmi $(docker images |egrep -v amazon-ecs|awk 'NR>1{print $3}') --force
cd ..
rm -fr /tmp/build_docker_image

#Just to speed up jnlp-slave agents
docker pull cloudbees/jnlp-slave-with-java-build-tools:latest
