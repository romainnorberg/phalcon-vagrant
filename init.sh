#!/bin/bash
# Using Precise32 Ubuntu

# -----------------------------------------------------------------------------
# Repositories
# -----------------------------------------------------------------------------
sudo apt-add-repository -y ppa:phalcon/stable
sudo apt-add-repository -y ppa:ondrej/php5

sudo apt-get install -y python-software-properties
sudo apt-get update

# -----------------------------------------------------------------------------
# MySQL with root:<no password>
# -----------------------------------------------------------------------------
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server

# -----------------------------------------------------------------------------
# PHP
# -----------------------------------------------------------------------------
sudo apt-get install -y php5 php5-dev apache2 libapache2-mod-php5 php5-mysql php5-curl php5-mcrypt libpcre3-dev php5-phalcon

# -----------------------------------------------------------------------------
# Redis
# -----------------------------------------------------------------------------
sudo apt-get install -y redis-server

# -----------------------------------------------------------------------------
# MongoDB
# -----------------------------------------------------------------------------
sudo apt-get install mongodb-clients mongodb-server

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------
sudo apt-get install -y make curl htop git-core vim

# -----------------------------------------------------------------------------
# Redis Configuration
# Allow us to Remote from Vagrant with default Port only
# -----------------------------------------------------------------------------
sudo cp /etc/redis/redis.conf /etc/redis/redis.bkup.conf
sudo sed -i 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis/redis.conf
sudo /etc/init.d/redis-server restart

# -----------------------------------------------------------------------------
# MySQL Configuration
# Allow us to Remote from Vagrant with default Port only
# -----------------------------------------------------------------------------
sudo cp /etc/mysql/my.cnf /etc/mysql/my.bkup.cnf
# Note: Since the MySQL bind-address has a tab cahracter I comment out the end line
sudo sed -i 's/bind-address/bind-address = 0.0.0.0#/' /etc/mysql/my.cnf

# -----------------------------------------------------------------------------
# Grant All Priveleges to ROOT for remote access
# -----------------------------------------------------------------------------
mysql -u root -Bse "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '' WITH GRANT OPTION;"
sudo service mysql restart


# -----------------------------------------------------------------------------
# Composer for PHP
# -----------------------------------------------------------------------------
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# -----------------------------------------------------------------------------
# Apache VHost (Default Vagrant)
# -----------------------------------------------------------------------------
cd ~
echo '<VirtualHost *:80>
        DocumentRoot /vagrant/www
</VirtualHost>

<Directory "/vagrant/www">
        Options Indexes Followsymlinks
        AllowOverride All
        Require all granted
</Directory>' > vagrant.conf

sudo mv vagrant.conf /etc/apache2/sites-available

# -----------------------------------------------------------------------------
# Update PHP Error Reporting
# -----------------------------------------------------------------------------
sudo sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/apache2/php.ini
sudo sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' /etc/php5/apache2/php.ini
sudo sed -i 's/display_errors = Off/display_errors = On/' /etc/php5/apache2/php.ini


# -----------------------------------------------------------------------------
# Install PhalconPHP DevTools
# -----------------------------------------------------------------------------
cd ~
echo '{"require": {"phalcon/devtools": "dev-master"}}' > composer.json
composer install
rm composer.json

sudo mkdir /opt/phalcon-tools
sudo mv ~/vendor/phalcon/devtools/* /opt/phalcon-tools
sudo ln -s /opt/phalcon-tools/phalcon.php /usr/bin/phalcon
sudo rm -rf ~/vendor

# -----------------------------------------------------------------------------
# Enable Modules
# -----------------------------------------------------------------------------
sudo a2enmod rewrite
sudo php5enmod phalcon
sudo php5enmod curl
sudo php5enmod mcrypt

# -----------------------------------------------------------------------------
# Reload apache
# -----------------------------------------------------------------------------
sudo a2ensite vagrant
sudo a2dissite 000-default
sudo service apache2 reload
sudo service apache2 restart
sudo service mongodb restart

# -----------------------------------------------------------------------------
# Final Output
# -----------------------------------------------------------------------------
echo -e "----------------------------------------"
echo -e "To create a Phalcon Project:\n"
echo -e "----------------------------------------"
echo -e "$ cd /vagrant/www"
echo -e "$ phalcon project projectname\n"
echo -e
echo -e "Then follow the README.md to copy/paste the VirtualHost!\n"

echo -e "----------------------------------------"
echo -e "Default Site: http://192.168.50.4"
echo -e "----------------------------------------"
