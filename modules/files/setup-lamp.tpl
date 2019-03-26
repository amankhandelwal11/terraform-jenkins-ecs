#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd

# optional
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
sudo echo -e "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

cat <<EOF> /var/www/html/index.html
<html>
<body>
<p>
<br>Hello World...!
<br>public_ip: `wget -q -O- http://169.254.169.254/latest/meta-data/public-ipv4`
<br>private_ip: `wget -q -O- http://169.254.169.254/latest/meta-data/local-ipv4`
</p>
</body>
</html>
EOF
