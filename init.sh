#!/bin/bash
# Ubuntu Precise32

# -----------------------------------------------------------------------------
# Repositories PPA
# -----------------------------------------------------------------------------
echo -e "Installing PPA Features\n"
sudo apt-get install python-software-properties -y # For PPA
sudo add-apt-repository ppa:phalcon/stable -y
sudo add-apt-repository ppa:ondrej/php5 -y

echo -e "Updating all Repositories\n"
sudo apt-get update

# -----------------------------------------------------------------------------
# Optional for searching files within packages of APT
# -----------------------------------------------------------------------------
# apt-get install apt-file
# apt-file update
# Warning: uses a LOT of space, you can run use $ apt-file purge to clear cache,
# or use rapt-file to see instructions for remote access without using disk space.

# -----------------------------------------------------------------------------
# MySQL with root:<no password>
# -----------------------------------------------------------------------------
echo -e "Setting up MySQL Server with (root:<no password>)\n"
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------
echo -e "Installing Linux Utilties\n"
sudo apt-get install -y make curl htop git-core vim

# -----------------------------------------------------------------------------
# PHP and Addons
# -----------------------------------------------------------------------------
echo -e "Installing PHP5\n"
sudo apt-get install -y php5 php5-dev php-apc apache2 libapache2-mod-php5 libpcre3-dev

# Modules for PHP5
echo -e "Installing PHP5 Modules\n"
sudo apt-get install -y php5-mysql php5-curl php5-mcrypt php5-intl php5-memcached

# APCu
echo -e "Installing PHP5 APCu\n"
cd ~
wget http://mirrors.kernel.org/ubuntu/pool/universe/p/php-apcu/php5-apcu_4.0.1-4_i386.deb
sudo dpkg -i php5-apcu_4.0.1-4_i386.deb

# -----------------------------------------------------------------------------
# Phalcon
# -----------------------------------------------------------------------------
echo -e "Installing Phalcon\n"
sudo apt-get install php5-phalcon

# -----------------------------------------------------------------------------
# Redis
# -----------------------------------------------------------------------------
echo -e "Install Redis\n"
sudo apt-get install -y redis-server

# Redis Configuration
# Allow us to Remote from Vagrant with default Port only
echo -e "Configuring Redis Port\n"
sudo cp /etc/redis/redis.conf /etc/redis/redis.bkup.conf
sudo sed -i 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis/redis.conf
sudo /etc/init.d/redis-server restart
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# MySQL Configuration
# Allow us to Remote from Vagrant with default Port only
# -----------------------------------------------------------------------------
# Create a backup of the default configuration
echo -e "Opening Local Access to MySQL\n"
sudo cp /etc/mysql/my.cnf /etc/mysql/my.bkup.cnf

# Note: Since the MySQL bind-address has a tab character I comment out the ending line with a #
sudo sed -i 's/bind-address/bind-address = 0.0.0.0#/' /etc/mysql/my.cnf

# Grant All Priveleges to ROOT for remote access
mysql -u root -Bse "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '' WITH GRANT OPTION;"
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Composer for PHP
# -----------------------------------------------------------------------------
echo -e "Installing PHP Composer\n"
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# -----------------------------------------------------------------------------
# Apache VHost (Default Vagrant)
# -----------------------------------------------------------------------------
echo -e "Creating Vagrant Base VHost\n"
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
echo -e "Configure PHP INI\n"
sudo sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/apache2/php.ini
sudo sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' /etc/php5/apache2/php.ini
sudo sed -i 's/display_errors = Off/display_errors = On/' /etc/php5/apache2/php.ini


# -----------------------------------------------------------------------------
# Install PhalconPHP DevTools
# -----------------------------------------------------------------------------
echo -e "Installing Phalcon DevTools\n"
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
echo -e "Enabling Modules\n"
sudo a2enmod rewrite
sudo php5enmod phalcon
sudo php5enmod curl
sudo php5enmod mcrypt
sudo php5enmod intl

# -----------------------------------------------------------------------------
# Reload apache
# -----------------------------------------------------------------------------
echo -e "Reloading Services\n"
sudo a2ensite vagrant
sudo a2dissite 000-default
sudo service apache2 reload
sudo service apache2 restart
sudo service mysql restart

# -----------------------------------------------------------------------------
# Final Output
# -----------------------------------------------------------------------------
echo -e "( * ) Installation Complete "
echo -e "( * ) Visit: http://192.168.50.4"
echo -e "----------------------------------------"
echo -e "To begin a new Phalcon Project:\n"
echo -e "----------------------------------------"
echo -e "$ cd /vagrant/www"
echo -e "$ phalcon project projectname\n"
echo -e
echo -e "Then follow the README.md to copy/paste the VirtualHost!\n"