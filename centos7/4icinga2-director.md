```sh
# Install Package 
yum install icinga-director

# Create database and permission for director
mysql -u root -p'8JhRykLKCrV48cYh'

CREATE DATABASE director CHARACTER SET 'utf8';
GRANT ALL ON director.* TO 'director'@'localhost' IDENTIFIED BY 'director';
FLUSH PRIVILEGES;

\q

# Let’s load the schema for the director database:
mysql -u root -p'8JhRykLKCrV48cYh' director < /usr/share/icingaweb2/modules/director/schema/mysql.sql

icingacli module enable director
systemctl restart icingadb && systemctl status icingadb