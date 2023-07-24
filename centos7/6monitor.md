```sh
## Now let’s install IDO for MySQL
yum install -y icinga2-ido-mysql

# Create the following databases for Icinga and Icinga Web:
mysql -u root -p'8JhRykLKCrV48cYh'

CREATE DATABASE icinga;
GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';
FLUSH PRIVILEGES;

\q;

## Now we need to import the Icinga 2 schema for our MySQL.
mysql -u root -p'8JhRykLKCrV48cYh' icinga < /usr/share/icinga2-ido-mysql/schema/mysql.sql

# Create file /etc/icinga2/features-enabled/ido-mysql.conf

icinga2 feature enable ido-mysql
systemctl restart icinga2

