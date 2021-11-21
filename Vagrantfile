# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  require './.vagrant/local.rb'
  local = Local.new()

  # Every Vagrant development environment requires a box.
  config.vm.box = "./build/box/WindowsServer2019.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.

  # Oracle VM VirtualBox will only allow IP addresses in 192.68.56.0/21 range to be
  # assigned to host-only adapters. For IPv6 only link-local addresses are allowed.
  # If other ranges are desired, they can be enabled by creating /etc/vbox/networks.conf
  # and specifying allowed ranges there. For example, to allow 10.0.0.0/8 and
  # 192.168.0.0/16 IPv4 ranges as well as 2001::/64 range put the following lines
  # into /etc/vbox/networks.conf:
  #     * 10.0.0.0/8 192.168.0.0/16
  #     * 2001::/64
  config.vm.network "private_network", ip: "192.168.56.100"

  config.vm.communicator = :winrm
  config.winrm.username = "Administrator"
  config.winrm.password = "vagrant"
  config.winrm.host = "localhost"
  config.vm.guest = :windows
  config.vm.boot_timeout = 60

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  #
  # Disable the default directory name within Windows
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # See https://www.vagrantup.com/docs/synced-folders/smb
  #
  config.vm.synced_folder ".", "/Host", type: "smb",
    smb_username: local.host_username,
    smb_password: local.host_password

  config.vm.provider "virtualbox" do |vb|
    vb.name   = "WindowsServer2019"
    vb.memory = local.memory
    vb.cpus   = local.cpus

    vb.customize ["modifyvm", :id, "--memory", local.memory]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--cpus", local.cpus]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # Display the VirtualBox GUI when booting the machine
    vb.gui = !local.headless
  end

  config.vm.provision "shell",  inline: <<-SHELL
    # This runs one for the first vagrant up

    # Enable Terminal Server connections into this box
    Set-ItemProperty -Path "HKLM:\\System\\CurrentControlSet\\Control\\Terminal Server" -Name fDenyTSConnections -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

    # Open up Network so it can see computers on your local network
    # See https://www.youtube.com/watch?v=vyatMj1Z2NQ
    Set-ItemProperty -Path "HKLM:\\System\\CurrentControlSet\\Services\\LanManWorkstation\\Parameters" -Name AllowInsecureGuestAuth -Value 0
  SHELL

#   config.vm.provision "shell", run: 'always', inline: <<-SHELL
#     # This runs for every vagrant up
#     Write-Output "Done."
#   SHELL
end
