#!/bin/bash

# Check if the user is root or not.
if [[ "${UID}" -ne 0 ]]
then
	echo "You need to be root to execute this script."
	exit 1
fi

# if no argument is given, show a usage
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]..."
	echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT."
	exit 1
fi

# The first parameter is the user name
USER_NAME=${1}

# the rest of the parameters are for the account comments.
shift
COMMENT=${@}

# generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c48) 

echo "$USER_NAME"
echo "$COMMENT"

# Create the user with the password
useradd -c ${COMMENT} -m ${USER_NAME}

# Checking if the user has been created
if [[ "$?" -ne 0 ]]
then
	echo "The account could not be created"
	exit 1
fi

# Set the password
echo "$PASSWORD" | passwd --stdin ${USER_NAME}

if [[ "$?" -ne 0 ]]
then
	echo "The passwd for the account could not be set"
	exit 1
fi

# force password change
passwd -e $USER_NAME

# Displaying info
echo
echo "username: ${USER_NAME}"
echo "password: ${PASSWORD}"
echo "host: ${HOSTNAME}"

exit 0

