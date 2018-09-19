#!/bin/bash

#This script creates an account on the local system.
#You will be prompted for the account name and password.

#First check that this script is being executed as the root user
if [ "$(id -u)" != 0 ] ; 
then
	echo 'You need to be root to run this script because it adds users.'
	exit 1
fi

#Ask for the user name.
read -p 'Type the username to create:  ' USER_NAME

#Ask for the real name.
read -p 'Type the real name of the account to create:  ' COMMENT

#Ask for password.
read -p 'Type the password of the account to create:  ' PASSWORD

#Check that input variables are not empty.
if [ -z "${USER_NAME}" ] || [ -z "${COMMENT}" ] || [ -z "${PASSWORD}" ] ; 
then
	echo 'The username, comment, and password cannot be empty'
	exit 1
fi

#Create the new user
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

