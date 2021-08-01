# Virtualization Software

Virtualization Softwares allows you to run an **unmodified operating system** with all of its **installed software** in a special environment on top of existing operating system. This special environment called a virtual machine is created by virtualization software by intercepting access to certain hardware components and certain features.

* Provides full virtualization
* Creates virtual machines.
* **Physical computer = host**
* **virtual computer = guest**
* **guest OS thinks it's using real hardware**. It allows to perform destructive actions inside the virtual machine and those actions are contained inside of that virtual machine and won't interfere with your actual physical computer.

# Vagrant

Vagrant is a command line tool to automate the creation of a virtual machine.

* easy to configure, reproducible environments.
* Provisions virtualbox virtual machines.
* **Box** = Operating System Image

```bash
# syntex
vagrant box add USER/BOX

# example
vagrant box add jasonc/centos7
```

* **Vagrant project** = Folder with a Vagrantfile.

```bash
mkdir vm1
cd vm1

# initializing the Vagrant project vm1
vagrant init USER/BOX

# bringing up an instance of that box
vagrant up      # vagrant will import the box into virtualbox and start it.
# if vagrant detects that the virtual machine already exists in virtualbos it will just simply start it.
```

* The virtual machine is started in **headless mode** meaning there is no user interface for the machine visible on **local host(physical computer) machine**.

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
vagrant reload [VM_NAME]        # halt then up command

vagrant suspend [VM_NAME]       # suspends the vm
vagrant resume [VM_NAME]        # resumes the vm

vagrant destroy [VM_NAME]       # removes the vm
```

## Vagrantfile - Configuration file

created when initializing vagrant project.

```bash
vagrant init USER/BOX

# Output
# Vagrantfile in the project folder.
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

> Default VM hostname = localhost

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

```bash
vagrant up              # run multiple vm
vagrant ssh server1     # connect to server1
```

While connecting to server1 communicate with server2

```bash
ping 10.2.3.5
```

# Shell Script

Shell Script is a file that contains a series of linux commands and shell statements. It's made up of plain text meaning ascii text.

* shell scripts **eliminate repetitive tasks throught automation**.
* if you have to do a task more than once, but it's something that rarely done. It's worth to make a shell script for it.
* if you are making notes that's a good sign that there's an easier way to do it.
* **speed of development is the main reason to use shell script rather than a compiled program.**
* performance & efficiency. The tradeoff is worth it when the shell script runs fast enough for the intended purpose.
* anything you can do at the command line can be automated with a shell script.

***syntex of a shell script***

```bash
#!/bin/bash         ## /bin/bash <FILENAME> get executed

# commands
```

> \# = Sharp
>
> ! = bang
>
> #! = Shebang

## Bash basics

* bash file don't need to be end with .sh.
* ```./``` here dot represents present directory. forward-slash is directory seperator.

```bash
-rw-r--r-- 1 vagrant vagrant    0 Aug  1 14:01 blah.sh  # do not have execute permission
./blah.sh
-bash: ./blah.sh: Permission denied
```


### Comments

* ```#``` is used for single line comment.

### chmod - change files mode bits

```bash
chmod +x <filename>     # owners executable permission granted
```

* r = 4, w = 2, x = 1

```bash
chmod 755 <filename>

# r = 4, w = 2, x = 1

# for current user/owner
## 7 = 4 + 2 + 1
##     r + w + x

# for group
## 5 = 4 + 1
##     r + x

# for others
## 5 = 4 + 1
##     r + x

```

### mv - move (rename) files

```bash
mv old_name rename
```

### type - shell commands type

```bash
type shell-command
```

### echo - print characters

* echo is a shell builin.
* if you want to echo exact same text within quotes use single quotes.
* if u want to interpret variables while echoing then use double-quotes.

```bash
type -a echo

# output
## echo is a shell builtin
## echo is /usr/bin/echo
```

```bash
echo "message1"
/usr/bin/echo "message2"

# output
# message1
# message2
```

### help - show help of a command

```bash
help <command>

help echo       # shows echo help page
```

* this command only shows shell builtin commands help page.
* u need to use -h/man for non-builtin commands.
* to exit from man page press 'q'.

```bash
man <command>
<command> -h        # non-shell builtin command

uptime -h
```

### bash variable

**syntex**

```bash
variable='value'    # no space between equal sign.
```

* no space between equal sign of a variable.
* to use variable use '$' (dollar sign) as prefix.
* '{}' curley braces is required to append text to variable.
* if a variable is not found then the variable place would be blank, it won't do anything.

#### variable reassingment/ changing value of a variable

```bash
variable='value'

variable='changed_value'
```

```bash
variable='value'

echo "$variable"

# output
## value

echo '$variable'

# output
## $variable

echo "${variable}able"

# output
## valueable

variable='valu'     # reassingment
```

