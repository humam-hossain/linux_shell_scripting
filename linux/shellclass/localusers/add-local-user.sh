#!/bin/bash

# Checking if this script is executed with superuser (root) privileges.
if [[ "UID" -ne 0 ]]
then
	echo "You need to be root to create a local user"
	exit 1
fi

# user info
read -p 'Enter username: ' USER_NAME
read -p 'Enter realname: ' COMMENT
read -p 'Enter initial password: ' PASSWORD

# Creating local user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Checking if the account is not able to be created
if [[ "${?}" -ne 0 ]]
then
	echo "The account could not be created"
	exit 1
fi

# Setting initial password to the user
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
	echo "The password for the account could not be set."
	exit 1
fi

passwd -e ${USER_NAME}

# Displays the username, password and host where the acount was created.
echo
echo "username: ${USER_NAME}"
echo "password: ${PASSWORD}"
echo "host: ${HOSTNAME}"

exit 0
