#!/bin/bash

source $1/helperFuncs/DB_list_menu.sh 
function mainDBMSMenu {
        echo -e "================== My DBMS ====================== \n"
        PS3=$'\n>>DBMS '
        COLUMNS=50
        select choice in " Create Database" " List Databases" " Connect to Database" " Drop Database" " Exit"
        do
            case $REPLY in 
                1) read -e -p "Database name: " name
                mkdir $1/$name
                ;;
                2) ls $1
                ;;
                3) read -e -p "Database name: " DBname
                   if [ -d $1/$DBname ]
                   then
                      cd $1/$DBname
                      echo ">> connected to $DBname successfully"
                      clear
                      DB_List $DBname
                   else
                      echo "DataBase does't exist"
                   fi
                ;;
                4) read -e -p "Database name: " name
                rm -r $1/$name
                ;;
                5) exit
                ;;
                *) echo "Invalid Option"
                ;;

            esac
        done
        
}