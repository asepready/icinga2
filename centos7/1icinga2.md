```sh
# https://icinga.com/blog/2020/07/10/icinga-2-icinga-web-2-and-director-kickstart-on-centos-7/

#Step 1: Now update / upgrade your CentOS Linux
yum update -y && yum upgrade -y


# Step 2: Install Icinga repository
yum install -y https://packages.icinga.com/epel/icinga-rpm-release-7-latest.noarch.rpm


# Step 3: Install EPEL repository
yum install -y epel-release


# Step 4: Let’s install some tools we could need later in our system
yum install -y git curl make gcc wget nano vim net-tools tar unzip zip python-devel python-pip python-setuptools


# Step 5: Install Icinga 2, enable and start the Icinga 2 service
yum install -y icinga2
systemctl enable icinga2
systemctl start icinga2
systemctl status icinga2


# Step 6: Install plugins-all
yum install -y nagios-plugins-all


#Step 7: When you make a change into Icinga files and you want to confirm all is correct before restarting,  you can run the following command
icinga2 daemon -C


#Step 8: If you are going to use SELINUX with Icinga 2, you need to install the following packages, and set rules for port 80 and 443
yum install -y icinga2-selinux

#Now proceed to apply firewall rules for port 80, as a best practice you should be using https and open 443 as well.
firewall-cmd --add-port=80/tcp && firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --add-port=443/tcp && firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload
firewall-cmd --list-ports

# Step 9: Installing and configuring MySQL as database for our Icinga:
yum install -y mariadb-server mariadb
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation

# Now let’s install IDO for MySQL
yum install icinga2-ido-mysql
mysql -u root -p'123456'

# Create the following databases for Icinga and Icinga Web:
CREATE DATABASE icinga;

#Now, configure the permissions for the database created in the step before:
GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icingapass';

# Create the database for Icinga Web 2:
CREATE DATABASE icingaweb;

# Now, configure permissions:
GRANT ALL PRIVILEGES ON icingaweb.* TO 'icingaweb'@'localhost' IDENTIFIED BY 'icingaweb';

# Deploy privileges:
FLUSH PRIVILEGES;

# Now, quit from the database:
QUIT


# Step 11: Now we need to import the Icinga 2 schema for our MySQL.
mysql -u root -p'123456' icinga < /usr/share/icinga2-ido-mysql/schema/mysql.sql


# Step 12: Enable the ido-mysql module in Icinga
icinga2 feature enable ido-mysql

# Now, restart icinga2 service
systemctl restart icinga2


# Step 13: Install Web Server
yum install -y httpd
systemctl enable httpd
systemctl start httpd


# Step 14: Configure Icinga 2 REST ApiUser
icinga2 api setup

#Now, edit the file nano /etc/icinga2/conf.d/api-users.conf and add the following lines:
object ApiUser "icingaweb2" {
password = "Wijsn8Z9eRs5E25d"
permissions = [ "status/query", "actions/*", "objects/modify/*", "objects/query/*" ]
}

#Don’t forget to edit nano /etc/icinga2/features-enabled/ido-mysql.conf 
#according to the configuration needed. Check an example below:
/**
* The IdoMysqlConnection type implements MySQL support
* for DB IDO.
*/
object IdoMysqlConnection "ido-mysql" {
user = "icinga"
password = "icinga"
host = "localhost"
database = "icinga"
}

# Now proceed to restart icinga2 service
systemctl restart icinga2


# Step 15: Let’s install the SCL repository, we’ll need it for Icinga Web 2
yum install -y centos-release-scl


# Step 16: Proceed to install Icinga Web and Icinga CLI
yum install -y icingaweb2 icingacli


# Step 17: Install SELINUX for Icinga Web 2 in case you could need it
yum install -y icingaweb2-selinux


# Step 18: Install PHP FPM and other PHP modules we could need
yum install -y rh-php73-php-mysqlnd rh-php73-php-fpm sclo-php73-php-pecl-imagick rh-php73-php-ldap rh-php73-php-pgsql rh-php73-php-xmlrpc rh-php73-php-intl rh-php73-php-gd rh-php73-php-pdo rh-php73-php-soap rh-php73-php-posix rh-php73-php-cli

# Then start and enable the service:
systemctl start rh-php73-php-fpm.service
systemctl enable rh-php73-php-fpm.service
systemctl restart httpd
systemctl restart rh-php73-php-fpm.service

# Now, let’s create the token for finishing Icinga Web 2 configuration through web interface:
icingacli setup token create


Step 19: Icinga Web 2 Configuration
Point your browser to :
http://icinga-server/icingaweb2/