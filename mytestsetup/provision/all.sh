#!/bin/bash

echo 'PATH=/usr/local/sbin/:/usr/sbin:/sbin:${PATH}' > /etc/profile.d/myfix.sh

# ssh keys for vagrant user
###########################
if [[ ! -f /home/vagrant/.ssh/id_rsa ]]
then
  cp /vagrant_provision/sshkeys/id_rsa /home/vagrant/.ssh/
  cp /vagrant_provision/sshkeys/id_rsa.pub /home/vagrant/.ssh/
  chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
  chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub
fi 

( grep -q "the_key_master" /home/vagrant/.ssh/authorized_keys ) || cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys


# ssh keys for root user
########################
if [[ ! -f /root/.ssh/id_rsa ]]
then
  mkdir -p /root/.ssh
  chown root:root /root/.ssh
  chmod 700 /root/.ssh
  cp /vagrant_provision/sshkeys/id_rsa /root/.ssh/
  cp /vagrant_provision/sshkeys/id_rsa.pub /root/.ssh/
  chown root:root /root/.ssh/id_rsa
  chown root:root /root/.ssh/id_rsa.pub
  chmod 600 /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa.pub
fi

if [[ ! -f /root/.ssh/authorized_keys ]]
then
  cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
else
  ( grep -q "the_key_master" /root/.ssh/authorized_keys ) || cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
fi


#install stuff
##############
yum -y install vim-enhanced
yum -y install epel-release
yum -y install scl-utils

