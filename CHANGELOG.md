# CHANGELOG

[August 6th, 2014]

### New Things
- Uses Phalcon PPA for the latest version (Also easier to update)
  - To upgrade [Phalcon](http://phalconphp.com) you would run `sudo apt-get --only-upgrade install php5-phalcon`
- Included PHP5 Module `php5-intl` (i18n)
- Included PHP Module `php5-memcached` (The better of the two)
- Included PHP Module `php5-apcu` (Non Distributed) Which is an APC stripped of opcode caching after the deployment of Zend OpCache in PHP 5.5.
- [Redis](http://redis.io) remains in place because it's lightweight and a good memcached alternative.
- (Optional, Uncomment in init.sh) `apt-file`, Searches files within APT packages.

### Other Notes
- Removed MongoDB (This is your choice to install under SSH)
- This does **not** use `mod_fcgi` nor `php-fpm`, but if there is a good reason for Dev Environment reasons, perhaps!
- Not Included `php5-redis`, I suggest using something like `predis` via `composer` to sync with Redis.

## UPGRADE INSTRUCTIONS
If are UPGRADING from a version earlier than `August 6th, 2014` you should re-provision your box:

    $ vagrant provision

### Starting Over
If all this fails, you can always prepare a fresh slate:

    $ vagrant destroy
    $ vagrant up

Keep in mind this will remove your `/etc/apache2/sites-available` folder, so you
would have to re-add them manually, or simply copy it via:

    $ mkdir /vagrant/www/sites-available
    $ cp /etc/apache2/sites-available/* /vagrant/www/`

Then once you resetup vagrant, SSH in (`vagrant ssh`) and do:

    `mv /vagrant/www/sites-available/* /etc/apache2/sites-available`

You would then `a2ensite` the sites-available you have, eg:

    a2ensite mysite


This will up


