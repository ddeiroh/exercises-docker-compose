Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  config.vm.synced_folder ".", "/exercise"
  # config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    # Customize the amount of memory on the VM:
    vb.memory = "4096"
    vb.cpus = 4
  end
  config.vm.provision "base", type: "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y bat vim linux-headers-$(uname -r)
  SHELL

  config.vm.provision "node", type: "shell", inline: <<-SHELL
    apt-get install -y curl
    curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
    apt-get upgrade -y && apt-get install -y nodejs
    node -v
  SHELL

  config.vm.provision "docker", type: "shell", inline: <<-SHELL
    sudo apt-get remove docker docker-engine docker.io containerd runc 2> /dev/null && \
    sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/$(lsb_release -is | awk '{print tolower($0)}')/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/$(lsb_release -is | awk '{print tolower($0)}') \
    $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    usermod -aG docker $USER
  SHELL
end
