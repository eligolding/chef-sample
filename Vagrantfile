Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/trusty64"
    #config.vm.box_url = "myawesomeurl.foogle"

    config.vm.network :private_network, ip: "192.168.33.101"
    #config.vm.network "forwarded_port", guest: 80, host: 8080

    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end

    config.vm.provision "chef_solo" do |chef|
        chef.add_recipe "main"
    end

    config.vm.synced_folder ".", "/var/www"

end