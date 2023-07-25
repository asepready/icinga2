```sh
# Set up Icinga DB
# To enable the icingadb feature use the following command:
icinga2 feature enable icingadb
systemctl restart icinga2

# Installing Icinga DB Package
yum install -y icingadb

# Add MariaDB Repository
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash

yum install -y mariadb-server mariadb 
systemctl enable mariadb && systemctl start mariadb && systemctl status mariadb 

# Set Password Root
mysql -u root -p''
USE mysql;
UPDATE user SET password=PASSWORD('8JhRykLKCrV48cYh') WHERE User='root' AND Host = 'localhost';
FLUSH PRIVILEGES;

# Set up a MySQL database for Icinga DB:
mysql -u root -p'8JhRykLKCrV48cYh'

# database icingadb
CREATE DATABASE icingadb;
CREATE USER 'icingadb'@'localhost' IDENTIFIED BY 'icingadb';
GRANT ALL ON icingadb.* TO 'icingadb'@'localhost';

# database icingaweb
CREATE DATABASE icingaweb;
CREATE USER 'icingaweb'@'localhost' IDENTIFIED BY 'icingaweb';
GRANT ALL PRIVILEGES ON icingaweb.* TO 'icingaweb'@'localhost';

FLUSH PRIVILEGES;

\q

mysql -u root -p'8JhRykLKCrV48cYh' icingadb </usr/share/icingadb/schema/mysql/schema.sql
mysql -u root -p'8JhRykLKCrV48cYh' icingaweb </usr/share/icingaweb2/schema/mysql.schema.sql

# Running Icinga DB
cp /etc/icingadb/config.yml /etc/icingadb/config.yml.orig
nano /etc/icingadb/config.yml

icinga2 feature enable icingadb && systemctl restart icinga2

systemctl enable --now icingadb && systemctl start icingadb && systemctl status icingadb
systemctl restart icingadb && systemctl status icingadb



