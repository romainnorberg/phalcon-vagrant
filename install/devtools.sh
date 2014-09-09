#!/bin/bash

#
# Install PhalconPHP DevTools
#
cd ~

# Create the JSON file and install the dependencies
echo '{"require": {"phalcon/devtools": "dev-master"}}' > composer.json
composer install
rm composer.json

sudo mkdir /opt/phalcon-tools\
        && mv ~/vendor/phalcon/devtools/* /opt/phalcon-tools\
        && ln -s /opt/phalcon-tools/phalcon.php /usr/bin/phalcon\
        && sudo rm -rf ~/vendor
