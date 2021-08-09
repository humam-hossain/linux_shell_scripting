#!/bin/bash
# suppress the output from all commands
# display error message through stderr

# ensuring root privileges
if [[ "$UID" -ne 0 ]]
then
    echo "You need to be root" >&2
    exit 1
fi

# check if there is at least 1 argument given
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [COMMENT...]" >&2
    echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT." >&2
	exit 1
fi

# first argument as user_name
USER_NAME="${1}"

# rest of the arguments should be comment
shift
COMMENT="${@}"

# automate password generate
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# create the user
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# check if the user is created
if [[ "$?" -ne 0 ]]
then
    echo "The account could not be created" >&2
    exit 1
fi

# set password to the user
echo "$PASSWORD" | passwd --stdin $USER_NAME &> /dev/null

# check if the password is set
if [[ "$?" -ne 0 ]]
then
    echo "The password could not be set" >&2
    exit 1
fi

# force user to change password in the first login
passwd -e $USER_NAME &> /dev/null

# Display username, password, host
echo "username: $USER_NAME"
echo "password: $PASSWORD"
echo "hostname: $HOSTNAME"

exit 0