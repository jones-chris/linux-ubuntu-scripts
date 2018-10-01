#!/bin/bash

#This script creates an account on the local system.
#You will be prompted for the account name and password.

#First check that this script is being executed as the root user
if [ "$(id -u)" != 0 ] ; 
then
	echo 'You need to be root to run this script because it adds users.'
	exit 1
fi

#Assign run-time arguments to variables.
USER_NAME=$1
COMMENT=$2

#Check that input variables are not empty.
if [ -z "${USER_NAME}" ] || [ -z "${COMMENT}" ] ;
then
        echo 'Error:  The username and comment cannot be empty'
        exit 1
fi

if [ "$3" != "" ] ; 
then
	echo 'Error:  This command only takes two arguments, username and comment.'
fi

#Generate random password.
PASSWORD_WITHOUT_SPECIAL_CHAR=$($(date +%s%N${RANDOM}${RANDOM}) | sha256sum | head -c48 | awk '{print $1}')
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
PASSWORD="${PASSWORD_WITHOUT_SPECIAL_CHAR}${SPECIAL_CHARACTER}"

#Create the new user.
useradd -c "${COMMENT}" -m ${USER_NAME}
OUTPUT=$?
if [ ${OUTPUT} -ne 0 ] ;
then
	echo 'There was an exception when running the useradd command'
	exit 1
fi

#Set the password for the user.
echo "${USER_NAME}:${PASSWORD}" | chpasswd


#Force password change on first login.
passwd -e ${USER_NAME}

#Display username, password, and host where account was created.
HOSTNAME=$(hostname)
echo "The user was created!" 
echo "Username:  $USER_NAME"
echo "Password:  $PASSWORD"
echo "Hostname:  $HOSTNAME"
