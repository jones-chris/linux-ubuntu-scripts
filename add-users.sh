#!/bin/bash

#This script creates an account on the local system.
#You will be prompted for the account name and password.

#Ask for the user name.
read -p 'Type the username to create:  ' USER_NAME

#Ask for the real name.
read -p 'Type the real name of the account to create:  ' COMMENT

#Ask for password.
read -p 'Type the password of the account to create:  ' PASSWORD

#Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

  #Check if user is root
  #if [[ $(id -u) != 0 ]] then
	#echo 'You need to be root to run this script because it adds users.'
	#exit(1)
  #fi
#Set the password for the user.
#echo ${PASSWORD} | chpasswd "${USER_NAME}:${PASSWORD}"
echo "${USER_NAME}:${PASSWORD}" | chpasswd

#Force password change on first login.
passwd -e ${USER_NAME}
