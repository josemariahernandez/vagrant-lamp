#!/usr/bin/env bash

apt-get update

#Instalamos Apache
apt-get install -y apache2
mkdir /vagrant/server


#Instalamos PHP5
apt-get install -y libapache2-mod-php5 
apt-get install -y php5-common 
apt-get install -y php5-dev
apt-get install -y php5-cli
apt-get install -y php5-fpm 
apt-get install -y curl 
apt-get install -y php5-curl 
apt-get install -y php5-gd 
apt-get install -y php5-mcrypt 
apt-get install -y php5-mysql 

#Reiniciamos el servidor web
/etc/init.d/apache2 restart
echo "ServerName localhost" | tee /etc/apache2/sites-available/fqdn.conf
ln -s /etc/apache2/sites-available/fqdn.conf /etc/apache2/sites-enabled/fqdn.conf

#Reiniciamos nuevamente el servidor web
/etc/init.d/apache2 restart

#Instalar debconf-utils
apt-get install -y debconf-utils

#Instalar mysql
echo 'mysql-server mysql-server/root_password password root' | debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | debconf-set-selections
apt-get install -y mysql-server

#Instalar PhpMyAdmin
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install -y phpmyadmin

ln -s /usr/share/phpmyadmin/ /var/www/phpmyadmin

#Reiniciamos nuevamente el servidor web
/etc/init.d/apache2 restart