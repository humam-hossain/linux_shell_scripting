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

## Bash Symbols

### Pipe symbol ( | )

when you use a pipe symbol on a command line it means take the standard output from the preceding command, the command that goes before the pipe, and pass it as the standard input to the following command or the command that comes after the pipe.

if the first command displays error messages those will not be passed to the second command. error messages are called standard error.

## Bash basics

* bash file don't need to be end with .sh.
* ```./``` here dot represents present directory. forward-slash is directory seperator.

```bash
-rw-r--r-- 1 vagrant vagrant    0 Aug  1 14:01 blah.sh  # do not have execute permission
./blah.sh
-bash: ./blah.sh: Permission denied
```

### bash - GNU Bourne-Again SHell

Bash is an **sh**-compatible command  language  interpreter  that executes commands read from the standard input or from a file.

**SYNOPSIS**

```bash
    bash [options] [file]
```

* commands and bash variables.

### COMMAND EXECUTION

After a command has been split into words, if it results in a simple command and an optional list of arguments, the following actions are taken.

If the command name contains no slashes, the shell attempts to locate it. If  there  exists a shell function by that name, that function is invoked
If the name does not match a  function, the  shell  searches for it in the list of shell builtins.  If a match is found, that builtin is invoked.

If the name is neither a shell function nor a builtin,  and  contains  no slashes,  **bash** searches each element of the **PATH** for a directory containing an executable file by that name.  **Bash** uses a **hash** table to  remember the full pathnames of executable files.
A full search of the directories in PATH is performed only if the command is not found in the hash table.  If the search is unsuccessful, the shell searches for a defined shell function named **command_not_found_handle**. If that function exists, it is invoked with the original command and the original command's arguments as its arguments, and the function's exit status becomes the exit status of the shell. If that function is not defined, the shell prints an error message and returns an **exit status of 127**.

If the search is successful, or if the command name contains one or more slashes, the shell executes the named program in a separate execution environment. Argument  0  is  set  to the name given, and the remaining arguments to the command are set to the arguments given, if any.

If this execution fails because the file is not in executable format, and the  file  is not a directory, it is assumed to be a shell script, a file containing shell commands.  A subshell is spawned to  execute  it. This subshell  reinitializes  itself,  so that the effect is as if a new shell had been invoked to handle the script, with the exception that the  locations  of  commands  remembered by the parent are retained by the child.

If the program is a file beginning with #!, the remainder  of  the  first line  specifies  an  interpreter for the program.  The shell executes the specified interpreter on operating systems that do not handle  this  executable format themselves.  The arguments to the interpreter consist of a single optional argument following the interpreter name on the first line of the program, followed by the name of the program, followed by the command arguments, if any.

### Comments

* ```#``` is used for single line comment.

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

### Special Variable

There are some special variable that are predefined by bash.

* **UID** = Expands to the user ID of the current user, initialized at shell startup.  This variable is readonly.
* **HOSTNAME** = contains name of the host.
* **RANDOM** = Each time this parameter is  referenced,  a random  integer between **0 and 32767** is generated. The sequence of random numbers maybe initialized by assigning a value to **RANDOM**.
* **PATH** = The search path for commands.  It is  a  colon-separated  list  of directories  in  which  the  shell looks for commands. 

### Special Parameters

The shell treats several parameters specially.  These parameters may only be referenced; assignment to them is not allowed.

* **?** = It holds the exit status of the last command.
* **#** = Expands to the number of positional parameters in decimal.
* **\*** = Expands  to  the positional parameters, starting from one. When the expansion occurs within double quotes, it expands to  a  single  word with the value of each parameter separated by the first character of the IFS special  variable. That is, ```"$*"``` is equivalent to ```"$1c$2c..."```, where c is the first character of the value of the IFS variable.
* **@** = Expands  to  the positional parameters, starting from one. When the  expansion  occurs  within  double  quotes,  each parameter  expands  to  a separate word.  That is, ```"$@"``` is equivalent to ```"$1" "$2" ...```  

### Assinging Command Ouput in a variable

**Syntex**

```bash
    VARIABLE=$(shell_command)
    VARIABLE=`shell_command`    # legacy style
```

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

### which - shows the full path of (shell) commands

Which takes one or more arguments. For each of its arguments it prints to stdout the full path of the executables that would have been executed when this argument had been entered at the shell prompt. It does this by searching for an executable or script in the directories listed in the environment variable **PATH** using the same algorithm as **bash(1)**.

**SYNOPSIS**
```bash
    which [options] [--] programname [...]
```

**Type**: which is aliased to ``` `alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde' ```. which is ```/usr/bin/which```
 
### echo - print characters

* echo is a shell builin.
* if you want to echo exact same text within quotes use single quotes.
* if u want to interpret variables while echoing then use double-quotes.

**Type** : echo is a shell builtin. echo is /usr/bin/echo

```bash
echo "message1"
/usr/bin/echo "message2"

# output
# message1
# message2
```

### cat  - concatenate files and print on the standard output

Concatenate FILE(s), or standard input,  to  standard output.

**SYNOPSIS**

```bash
    cat [OPTION]... [FILE]...
```

* **-n, --number** : number all output lines

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

### man - an interface to the on-line reference manuals

* [Option] - third brackets means optionals.
* ... - referred as ellipsis means multiple.

### id - print real and effective user and group IDs

***SYNOPSIS***

```bash
    id [OPTION]... [USER]
```

* [OPTION] - optional not mandatory
* ... - three dots referred as ellipsis, means you can specify multiple options.
* [USER] - one option user only.
* -n, --name = print a name instead of a number, for -ugG.
* -u, --user = print only the effective user ID.

### whoami - print effective userid

**DESCRIPTION**
       Print  the  user  name associated with the current effective user
       ID.  Same as id -un.
**SYNOPSIS**

```bash
    whoami [OPTION]...
```

* [OPTION] - optional not mandatory
* ... - three dots referred as ellipsis, means you can specify multiple options.

### exit

Exits the shell with a status of N.  If N is omitted, the exit status is that of the last command executed.

**Syntex**

```bash
    exit [n]
```

**Type** : exit is a shell builtin

### su - Suspend shell execution

**Syntex**

```bash
    suspend [-f]
```

**Type** : su is /bin/su. su is /usr/bin/su.

## Conditionals

### if statement

**Syntex**

```bash
if [[ <expression> ]]
then
    # commands
else
    # commands
fi

if COMMANDS; then COMMANDS; [ elif COMMANDS; then COMMANDS; ]... [ else COMMANDS; ] fi
# ; semi-colons are command seperators.
```

**Type** : if is a shell keyword

* if is a shell keyword so we can use help keyword.

> ; semi-colons are command seperators.

### \[[ ... ]]: \[[ expression ]] - Execute conditional command.

Returns a status of 0 or 1 depending on the evaluation of the conditional.

**Type** : [[ ]] is a shell keyword

Exit Status:
0 or 1 depending on value of EXPRESSION.

* 0 = true
* 1 = false

### test - Evaluate conditional expression

Exits with a status of 0 (true) or 1 (false) depending on
the evaluation of EXPR.

**Syntex**

```bash
    test [expr]
```

**Type**: test is a shell builtin. test is a command located at /usr/bin/test.

### exec - Replace the shell with the given command.

Execute COMMAND, replacing this shell with the specified program. ARGUMENTS become the arguments to COMMAND. If COMMAND is not specified, any redirections take effect in the current shell.
**Syntex**

```bash
exec [-cl] [-a name] [command [arguments ...]] [redirection ...]
```

**Type** : exec is a shell builtin.

```bash
    exec zsh    # run zsh shell
```

### read - Read a line from the standard input

Read a line from the standard input and split it into fields.

> Standard input means the input comes from the keyboard by default. but an input can come from various input devices. Standard input can come from another command when it's used & it's called a pipeline ( | ).
>
> Standard output & standard error mean output/error displayed on the monitor.

**Syntex**

```bash
read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]
```

**Type**: read is a shell builtin. read is /usr/bin/read.

* **-p prompt** = output the string PROMPT without a trailing newline before attempting to read.

```bash
read -p "Type something: " THING
# Type something: something

echo ${THING}
# something
```

### Equal Sign (=)

* ```=``` is used for variable assignment.
* it can be used for exact match between two strings.

### Double Equal Sign (==)

* ```==``` is used for pattern matching.

## Local User

* Only root user can create local users/add users.
* **/etc/login.defs** - local user configuration file

### useradd - create a new user or update default new user information

**SYNOPSIS**

```bash
    useradd [options] LOGIN

    useradd -D

    useradd -D [options]
```

* usernames/logins have typically 8 characters or less by convention. 
* When invoked without the -D option, the useradd command creates a new user account using the values specified on the command line plus the default values from the system.
* **-c, --comment** = COMMENT. usually used for user's real name.

### passwd - update user's authentication tokens

The  passwd  utility  is  used  to  update  user's
authentication token(s).
**SYNOPSIS**

```bash
    passwd  [-k] [-l] [-u [-f]] [-d] [-e] [-n mindays] [-x maxdays] [-w warndays] [-i inactivedays]  [-S] [--stdin] [username]
```

* **--stdin** : This option is used to indicate that passwd should  read the new password from standard input, which can be a pipe.
* **-e, --expire** : This is a quick way to  expire  a  password for  an account. The user will be forced to change the password during the  next  login attempt.  Available to root only.

### date - print or set the system date and time

Display  the  current time in the given FORMAT, or set the system date.
**SYNOPSIS**

```bash
    date [OPTION]... [+FORMAT]
    date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
```

* **%s** = seconds since 1970-01-01 00:00:00 UTC. It's a format.
* **%N** = nanoseconds (000000000..999999999). It's a format.

## Cryptographic Hash / Checksum

### sha256sum - - compute and check SHA256 message digest

Print or check SHA256 (256-bit) checksums.  With no FILE, or when FILE is -, read standard input.

**SYNOPSIS**

```bash
    sha256sum [OPTION]... [FILE]...
```

> pipe can be used where there is a file option in every command.

### head - output the first part of files

Print the first 10 lines of each FILE to standard output.  With more than
one FILE, precede each with a header giving the file name.  With no FILE,
or when FILE is -, read standard input.

**SYNOPSIS**

```bash
    head [OPTION]... [FILE]...
```

* -c, --bytes=[-]K = print  the first K bytes of each file; with the leading '-', print
all but the last K bytes of each file

* -n, --lines=[-]K = print the first K lines instead of the first 10; with the  leading
'-', print all but the last K lines of each file

### hash - Remember or display program locations.

Determine and remember the full pathname of each command NAME.  If no arguments are given, information about remembered commands is displayed.

**Syntax**

```bash
    hash [-lr] [-p pathname] [-dt] [name ...]
```

**Type** - hash is a shell builtin

* -r = forget all remembered locations

### shuf - generate random permutations

Write a random permutation of the input lines to standard output.

**SYNOPSIS**

```bash
    shuf [OPTION]... [FILE]
    shuf -e [OPTION]... [ARG]...
    shuf -i LO-HI [OPTION]...
```

### fold - wrap each input line to fit in specified width

Wrap  input  lines  in  each FILE (standard input by default), writing to standard output.

**SYNOPSIS**

```bash
    fold [OPTION]... [FILE]...
```

* -b, --bytes = count bytes rather than columns
* -c, --characters = count characters rather than columns
* -s, --spaces = break at spaces
* -w, --width=WIDTH = use WIDTH columns instead of 80

```bash
    S = 'hello'
    echo "$S" | fold -w1

# Output
## h
## w
## l
## l
## o
```

### basename - strip directory and suffix from filenames

Print  NAME with any leading directory components removed. If specified, also remove a trailing SUFFIX.

**SYNOPSIS**

```bash
    basename NAME [SUFFIX]
    basename OPTION... NAME...
```
* doesn't do any smart checking.

```bash
    basename /vagrant/luser-demo06.sh 

# Output
## luser-demo06.sh
```

### dirname - strip last component from file name

Print  NAME with any leading directory components removed.  If specified, also remove a trailing SUFFIX.

**SYNOPSIS**

```bash
    basename NAME [SUFFIX]
    basename OPTION... NAME...
```

* doesn't do any smart checking.

```bash
    dirname /vagrant/luser-demo06.sh 

# Output
## /vagrant
```

## Data Munging / String manipulation in bash

Pipe is used for data munging/string manipulation. we can pipe a standard output
to a command for standard input. multiple pipe can be used in this manner. This is
how we can do string manipulation.

## Parameter & Argument

A parameter is a variable that is being used inside the shell script.

An Argument is the data passed into the shell script. So an argument is
applied on the command line becomes the value stored in a parameter.

* ```${0}``` is the very first positional parameter that contains the name of the
script itself.
* The next postional parameter is ```${1}``` which stores the value of the
first argument passed to the script on the command line. The positional
parameter ```${2}``` stores the second argument, ```${3}``` stores the third
argument & so on.

## Loops

### for loop

Execute commands for each member in a list.

The ```for``` loop executes a sequence of commands for each member in a list of items.  If ```in WORDS ...;``` is not present, then ```in "$@"``` is assumed.  For each element in ```WORDS```, ```NAME``` is set to that element, and the COMMANDS are executed.

**Syntex**

```bash
    for NAME [in WORDS ... ]
    do 
        COMMANDS 
    done
```

**Type** : for is a shell keyword.
**Exit Status** : Returns the status of the last command executed.

### While - Execute commands as long as a test succeeds

**Syntax**

```bash
    while COMMANDS
    do 
        COMMANDS
    done
```

**Type** : while is a shell keyword.
**Exit Status** : Returns the status of the last command executed.

### True - Return a successful result

**SYNOPSIS**

```bash
    true [ignored command line arguments]
    true OPTION
```

**Type** : ```true``` is a shell builtin. ```true``` is ```/usr/bin/true```.
**Exit Status**: Always succeeds.

```bash
    true
```

### sleep - delay for a specified amount of time

Pause  for  NUMBER seconds.  SUFFIX may be 's' for seconds (the default), 'm' for  minutes,  'h'  for hours  or  'd'  for days.

**SYNOPSIS**

```bash
    sleep NUMBER[SUFFIX]...
    sleep OPTION
```

**Type** : It is an executable program. ```sleep``` is ```/usr/bin/sleep```.

### shift - Shift positional parameters

Rename the positional parameters ```$N+1,$N+2 ... to $1,$2 ...``` If N is not given, it is assumed to be 1.

```bash
    shift [n]
```

**Type** : shift is a shell builtin.
**Exit Status** : Returns success unless N is negative or greater than ```$#```.

## I/O

There are 3 types of I/O.

1. Standard Input - by default comes from keyboard. Pipe (|) is another way to give standard input. Redirect standard output is less than sign (<)
2. Standard Output - by default diplayed to the screen. Greater than sign (>) can redirect standard output. This type of redirection can overright contents. to add contents use double greater than sign (>>).
3. Standard Error - by default diplayed to the screen.

### File Descriptor

A file descriptor is simply a number that represents an open file.
It is easier to reference files by name but it's easier for computers to reference them by number by default.
Every new process starts with three open file descriptors.

1. FD 0 - stdin
2. FD 1 - stdout
3. FD 2 - stderr

> FD = File descriptor

Someone may think that by default standard input comes from keyboard but keyboard isn't a file and by default standard output and standard error are displayed to screen but screen isn't a file either. At one level that's true but ***linux practically treats everything as a file***.

Perheps a more accurate description of a file descriptor is that it's a way that a program interacts with files or to other resources that works like files. These other resources include devices such as **keyboard, terminal, screen** and so on.
This abstraction of treating almost everything like a file allows to do some really powerfull things.

So **file descriptors are like pointers to sources of data or places that data can be written things like keyboads, files, screens** and so on.

Typically file descriptors are set by default so it is used implicitly. For example when we redirect standard input into a command, file descriptor zero is assumed.

```bash
    read X < /etc/centos-release    # here file desciptor is set to zero by default.
    echo $X

    #output
    ##CentOS Linux release 7.4.1708 (Core)
```

Explicitly using file descriptor in a file operation.

```bash
    read X 0< /etc/centos-release    # here 0 is the file descriptor set manually.
    echo $X

    #output
    ##CentOS Linux release 7.4.1708 (Core)
```

> Notice that there is no space between file descriptor zero in this case and the redirection operator the less than sign in this case. This is very important.
> >
> if you leave a space then what you thought was a file descriptor number that you were specifying ends up being an argument to the command before the redirection operator.

Normally with the redirection of a file follows the redirection operator. However if you want to use a file descriptor instead of a file name use the ampersand(&) symbol.

> There shouldn't be any space between redirection sign and ampersand(&)

```bash
    # Old way
    head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1
```

```bash
    # new way
    head -n1 /etc/passwd /etc/hosts /fakefile &> head.both
```

To summarize each new process starts with three open file descriptors.

```bash
    command &> FILE
    command |& command
```

## Null Device/ Bit bucket

The null device is a special file that throws away whatever is sent to it.

If you don't want to see output on your screen and you don't want to save that output to a file either than redirect that ouput to the null device which is located at ```/dev/null```

```bash
    command > /dev/null
```
