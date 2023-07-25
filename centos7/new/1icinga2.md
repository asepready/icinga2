```sh
# Add Icinga Package Repository 
yum install wget -y
tps://packages.icinga.com/icinga.key
wget https://packages.icinga.com/centos/ICINGA-release.repo -O /etc/yum.repos.d/ICINGA-release.repo

yum install -y epel-release
yum install -y git curl make gcc nano net-tools tar unzip zip python-devel python-pip python-setuptools

## Install Icinga 2 
yum install -y icinga2-selinux
firewall-cmd --add-port=80/tcp && firewall-cmd --permanent --add-port=80/tcp && firewall-cmd --reload && firewall-cmd --list-ports
firewall-cmd --add-port=443/tcp && firewall-cmd --permanent --add-port=443/tcp && firewall-cmd --reload && firewall-cmd --list-ports
yum install -y icinga2
systemctl enable icinga2 && systemctl start icinga2 && systemctl status icinga2

## Systemd Service
icinga2 daemon -C

## Install plugins-all
yum install -y nagios-plugins-all


## Set up Icinga 2 API
icinga2 api setup

## Backup file 
cp /etc/icinga2/conf.d/api-users.conf /etc/icinga2/conf.d/api-users.conf.orig
nano /etc/icinga2/conf.d/api-users.conf
systemctl restart icinga2 && systemctl status icinga2