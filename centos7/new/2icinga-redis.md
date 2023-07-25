```sh
# Set up Redis Server 
yum install -y icingadb-redis

## Run Icinga DB Redis 
systemctl enable --now icingadb-redis && systemctl start icingadb-redis && systemctl status icingadb-redis

# Enable Remote Redis Connections
# Configure /etc/icingadb-redis/icingadb-redis.conf
cp /etc/icingadb-redis/icingadb-redis.conf /etc/icingadb-redis/icingadb-redis.conf.orig

## Restart Icinga DB Redis
systemctl restart icingadb-redis && systemctl status icingadb-redis
