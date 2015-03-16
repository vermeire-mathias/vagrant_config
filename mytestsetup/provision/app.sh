#!/bin/bash

sudo yum -y install nginx

if [ ! -L /etc/nginx ]
then
  rm -rf /etc/nginx
  ln -s /vagrant_config/$(hostname -s)/nginx /etc/nginx
fi

if [ ! -L /var/www ]
then
  rm -rf /var/www
  ln -s /vagrant_config/www/ /var/www
fi
