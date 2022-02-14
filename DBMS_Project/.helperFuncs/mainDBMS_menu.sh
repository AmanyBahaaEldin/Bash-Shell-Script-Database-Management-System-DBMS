#!/bin/bash

function mainDBMSMenu {
        echo -e "================== My DBMS ====================== \n"
        PS3=$'\n>>DBMS '
        COLUMNS=50
        select choice in " Create Database" " List Databases" " Connect to Database" " Drop Database"
        do
            case $REPLY in 
                1) read -e -p " Database name: " name
                mkdir $name
                ;;
                2) ls 
                ;;
                3) read -e -p "Database name: " DBname
                cd $DBname
                # pwd
                # ls
                break 2 
                ;;
                4) read -e -p "Database name: " name
                rm -r $name
                ;;

            esac
        done
        
}