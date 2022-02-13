#!/bin/bash
echo -e "================== My DBMS ====================== \n"
PS3=$'\nSelect Choice: '
COLUMNS=50
select choice in " Create Database" " List Databases" " Connect to Database" " Drop Database"
do
	case $REPLY in 
		1) read -e -p "Please Enter Your database name: " name
		   mkdir $name
		;;
		2) ls 
		;;
		3) read -e -p "Please Enter the database name: " name
		  cd $name
		  pwd
		  ls
		;;
		4) read -e -p "Please Enter the database name: " name
		  rm -r $name
		;;

	esac
done
