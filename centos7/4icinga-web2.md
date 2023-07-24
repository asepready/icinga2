```sh
#  Icinga Web 2
# Let’s install the SCL repository, we’ll need it for Icinga Web 2
yum install -y centos-release-scl

#  Proceed to install Icinga Web and Icinga CLI & Install SELINUX for Icinga Web 2 in case you could need it
yum install -y icingaweb2 icingadb-web icingacli icingaweb2-selinux

# Install Web Server
yum install -y httpd mod_ssl
systemctl enable httpd && systemctl start httpd && systemctl status httpd

# Package PHP
yum install -y rh-php73-php-mysqlnd rh-php73-php-fpm sclo-php73-php-pecl-imagick rh-php73-php-ldap rh-php73-php-pgsql rh-php73-php-xmlrpc rh-php73-php-intl rh-php73-php-gd rh-php73-php-pdo rh-php73-php-soap rh-php73-php-posix rh-php73-php-cli

systemctl enable rh-php73-php-fpm.service && systemctl start rh-php73-php-fpm.service && systemctl status rh-php73-php-fpm.service 
systemctl restart httpd && systemctl restart rh-php73-php-fpm.service

# Install the Web Server
icingacli setup config webserver nginx --document-root /usr/share/icingaweb2/public

# Prepare Web Setup
icingacli setup token create
icingacli setup token show

# Start Web Setup ¶
# /icingaweb2/setup

# User Group 
groupadd --system icingaweb2
usermod -a -G icingaweb2 apache

