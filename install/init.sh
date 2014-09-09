#!/bin/bash

#
# Init
#

# Add PPA Ability
sudo apt-get install -y python-software-properties

# Add PPA Repositories
sudo add-apt-repository ppa:ondrej/php5 -y
sudo add-apt-repository ppa:phalcon/stable -y

# Update Repositories
sudo apt-get update

#
# PHP
#
sudo apt-get install -y\
        php5\
        php5-dev\
        php5-mysql\
        php5-xcache\
        php5-phalcon\
        php5-curl\
        php5-memcached\
        #php5-mcrypt\ # You must do this manually [Ondrej PPA Bug]
        #php5-intl\ # You must do this manually [Ondrej PPA Bug]
        php5-xdebug

#
# Apache
#
sudo apt-get install -y\
        apache2\
        libapache2-mod-php5\
        libpcre3-dev

#
# Utilities
#
sudo apt-get install -y make\
    curl\
    htop\
    git-core\
    vim

#
# Enable Modules
#
sudo a2enmod    rewrite
sudo php5enmod  phalcon\
                curl\
                #mcrypt\ # You must do this manually [Ondrej PPA Bug]
                #intl\ # You must do this manually [Ondrej PPA Bug]
                xcache\
                xdebug\
                memcached

#
# Composer for PHP
# Global usage: $ composer <cmd>
#
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#
# Apache VHost
#
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


#
# Update PHP Error Reporting
#
sudo sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/apache2/php.ini
sudo sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' /etc/php5/apache2/php.ini
sudo sed -i 's/display_errors = Off/display_errors = On/' /etc/php5/apache2/php.ini

# Append session save location to /tmp to prevent errors in an odd situation..
sudo sed -i '/\[Session\]/a session.save_path = "/tmp"' /etc/php5/apache2/php.ini

#
# Reload apache
#
sudo a2ensite vagrant
sudo a2dissite 000-default
sudo service apache2 reload
sudo service apache2 restart