```sh
# Install Package 
yum install icinga-x509

# Create database and permission for director
mysql -u root -p'8JhRykLKCrV48cYh'

CREATE DATABASE x509;
GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON x509.* TO x509@localhost IDENTIFIED BY 'nAUpKb8epY8k';

\q

# Let’s load the schema for the director database:
mysql -p'8JhRykLKCrV48cYh' -u root x509 < /usr/share/icingaweb2/modules/x509/schema/mysql.schema.sql


icingacli module enable director
systemctl restart icingadb && systemctl status icingadb