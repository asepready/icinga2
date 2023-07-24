```sh
# Set up Redis Server 
yum install icingadb-redis

## Run Icinga DB Redis 
systemctl enable --now icingadb-redis && systemctl start icingadb-redis && systemctl status icingadb-redis

# Enable Remote Redis Connections
# Configure /etc/icingadb-redis/icingadb-redis.conf
requirepass n47QMMSPXshwhaI3

firewall-cmd --add-port=6380/tcp
firewall-cmd --permanent --add-port=6380/tcp
firewall-cmd --reload

## Restart Icinga DB Redis
systemctl restart icingadb-redis && systemctl status icingadb-redis
