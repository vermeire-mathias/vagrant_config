yum -y install haproxy

dir="haproxy"

if [ ! -L /etc/$dir ]
then
  rm -rf /etc/$dir
  ln -s /vagrant_config/$(hostname -s)/$dir /etc/$dir
fi

