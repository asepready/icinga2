```sh
# Install Package 
yum install icinga-director

# Create database and permission for director
mysql -u root -p'8JhRykLKCrV48cYh'

CREATE DATABASE director CHARACTER SET 'utf8';
GRANT ALL ON director.* TO 'director'@'localhost' IDENTIFIED BY 'director';
FLUSH PRIVILEGES;

\q

# Create FIle director.sh
chmod 777 director.sh
./director.sh

# Let’s load the schema for the director database:
mysql -u root -p'8JhRykLKCrV48cYh' director < /usr/share/icingaweb2/modules/director/schema/mysql.sql

icingacli module enable director
systemctl restart icingadb && systemctl status icingadb
## You need now to log in into your Icinga Web, and create a new resource. Go to Configuration -> Application -> Resources. Then click Create New Resource, you need to set Resource Name, Database Name, Username, Password and Character Set. After that click on Validate Configuration, and if everything is OK, then click on Save Changes. During the Kickstart process of Icinga Director you will need to provide the credentials for an ApiUser, you can use the root user defined in api-users.conf.
# Now create a file named director-service.sh, give execution permission and execute it

chmod +x director-service.sh
./director-service.sh