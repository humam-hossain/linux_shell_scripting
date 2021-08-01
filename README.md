# Shell Script

Shell Script is a file that contains a series of linux commands and shell statements. It's made up of plain text meaning ascii text. 

* shell scripts eliminate repetitive tasks throught automation.
* have to do a task more than once, but it's something that rarely done. It's worth to make a shell script for it.
* if you are making notes that's a good sign that there's an easier way to do it.
* speed of development is the main reason to use shell script rather than a compiled program.
* performance & efficiency. The tradeoff is worth it when the shell script runs fast enough for the intended purpose
* anything you can do at the command line can be automated with a shell script.

# Virtualization Software

Virtualization Softwares allows you to run an unmodified operating system with all of its installed software in a special environment on top of existing operating system. This special environment called a virtual machine is created by virtualization software by intercepting access to certain hardware components and certain features.

* Provides full virtualization
* Creates virtual machines.
* Physical computer = host
* virtual computer = guest
* guest OS thinks it's using real hardware. It allows to perform destructive actions inside the virtual machine and those actions are contained inside of that virtual machine and won't interfere with your actual physical computer.

# Vagrant

Vagrant is a command line tool to automate the creation of a virtual machine.

* easy to configure, reproducible environments.
* Provisions virtualbox virtual machines.
* Box = Operating System Image

```bash
# syntex
vagrant box add USER/BOX

# example
vagrant box add jasonc/centos7
```

* Vagrant project = Folder with a Vagrantfile.

```bash
mkdir vm1
cd vm1

# initializing the Vagrant project vm1
vagrant init USER/BOX

# bringing up an instance of that box
vagrant up      # vagrant will import the box into virtualbox and start it.
# if vagrant detects that the virtual machine already exists in virtualbos it will just simply start it.
```

* The virtual machine is started in headless mode meaning there is no user interface for the machine visible on local host(physical computer) machine.

## Vagrant Up/Multi-machine

```bash
# syntex
vagrant up [VM_name] # run specific vm

vagrant up # run all the vm found in Vagrantfile
```

## SSH - Secure SHell

ssh is the network protocol used to connect to linux systems.
vagrant provides shortcut access to ssh into the virtual machine.

```bash
vagrant ssh [VM_NAME] # to log in linux system

# logout
exit
```

## Stop the virtual machine

```bash
vagrant halt [VM_NAME]          # stops the vm
vagrant up [VM_NAME]            # starts the vm

vagrant suspend [VM_NAME]       # suspends the vm
vagrant resume [VM_NAME]        # resumes the vm

vagrant destroy [VM_NAME]       # removes the vm
```

## Vagrantfile

created when initializing vagrant project.

```bash
vagrant init USER/BOX
```

This file contains:
```bash
# all the configuration starts from here
Vagrant.configure(2) do |config|
            # conf version        
    config.vm.box = "jasonc/centos7"
    config.vm.hostname = "linuxsvr1"
    config.vm.network "private_network", ip: "10.2.3.4"

    config.vm.provision "shell", path: "setup.sh"
    # this provisioning system allows automatically install 
    #  software, alter configurations and more

    # changing default settings of virtualization software
    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.memory = "1024"
    end
end                                     
```

### multi-machine setup

```bash
Vagrant.configure(2) do |config|
    config.vm.box = "jasonc/centos7"

    config.vm.define "server1" do |server1|
        server1.vm.hostname = "server1"
        server1.vm.network "private_network", ip: "10.2.3.4"
    end

    config.vm.define "server2" do |server2|
        server1.vm.hostname = "server2"
        server1.vm.network "private_network", ip: "10.2.3.5"
    end
end
```
