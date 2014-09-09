# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Base Box
  # --------------------
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Connect to IP
  # Note: Use an IP that doesn't conflict with any OS's DHCP (Below is a safe bet)
  # --------------------
  config.vm.network :private_network, ip: "192.168.50.4"

  # Forward to Port
  # --------------------
  #config.vm.network :forwarded_port, guest: 80, host: 8080

  # Optional (Remove if desired)
  config.vm.provider :virtualbox do |v|
    # How much RAM to give the VM (in MB)
    # -----------------------------------
    v.customize ["modifyvm", :id, "--memory", "500"]

    # Uncomment the Bottom two lines to enable muli-core in the VM
    #v.customize ["modifyvm", :id, "--cpus", "2"]
    #v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Provisioning Script
  # --------------------

  # The Init Script
  config.vm.provision "shell", path: "install/init.sh"

  # Comment out anything you don't want, otherwise you can install them later
  # with $ sudo basah file.sh
  config.vm.provision "shell", path: "install/mysql.sh"
  config.vm.provision "shell", path: "install/redis.sh"
  config.vm.provision "shell", path: "install/devtools.sh"
  config.vm.provision "shell", path: "install/python.sh"

  # Output the completed details
  config.vm.provision "shell", inline: <<SCRIPT
echo -e "----------------------------------------\n\
To create a Phalcon Project:\n\
----------------------------------------\n\
$ cd /vagrant/www\n\
$ phalcon project projectname\n\n\

Then follow the README.md to copy/paste the VirtualHost!\n\n\

----------------------------------------\n\
Default Site: http://192.168.50.4\n\
----------------------------------------\n"
SCRIPT


  # Synced Folder
  # --------------------
  config.vm.synced_folder ".", "/vagrant/", :mount_options => [ "dmode=777", "fmode=666" ]
  config.vm.synced_folder "./www", "/vagrant/www/", :mount_options => [ "dmode=775", "fmode=644" ], :owner => 'www-data', :group => 'www-data'

end
