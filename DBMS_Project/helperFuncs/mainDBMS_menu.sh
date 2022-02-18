#!/bin/bash

source $1/helperFuncs/DB_list_menu.sh 
function mainDBMSMenu {
        echo -e "\e[1;34m\n================== My DBMS ====================== \e[0m\n"
        PS3=$'\n\u001b[31m>>DBMS: \u001b[0m'
        COLUMNS=50
        select choice in " Create Database" " List Databases" " Connect to Database" " Drop Database" " Exit"
        do
            case $REPLY in 
                1) read -e -p "Enter Database name: " name
               if [ -z "$name" ]
               then 
               echo -e "\e[1;31m Please enter correct DB name ...\e[0m"
               else
                  if [ ! -d $1/$name ]
                  then
                  mkdir $1/$name
                  echo -e "\e[1;32m $name database created successfully \e[0m"
                  else
                  echo -e "\e[1;33m $name database already exists \e[0m"
                  fi
               fi
                ;;
                2) ls $1
                ;;
                3) read -e -p "Enter Database name: " DBname
                   if [ -z "$DBname" ]
                   then 
                   echo -e "\e[1;31m Please enter correct DB name ...\e[0m"
                   else
                     if [ -d $1/$DBname ]
                     then
                        pwd
                        cd $1/$DBname
                        echo -e "\e[1;32m>> connected to $DBname successfully\e[0m"
                        clear
                        DB_List $DBname 
                     else
                        echo -e "\e[1;31m DataBase does't exist \e[0m"
                     fi
                  fi
                ;;
                4) read -e -p "Enter Database name: " name
                if [ -z "$name" ]
                then 
                echo -e "\e[1;31m Please enter correct DB name ...\e[0m"
                else
                  if [ -d $1/$name ]
                  then
                  rm -r $1/$name
                  echo -e "\e[1;32m $name database removed successfully \e[0m"
                  else
                  echo -e "\e[1;31m $name database doesn't exist \e[0m"
                  fi
                fi
                ;;
                5) exit
                ;;
                *) echo -e "\e[1;31mInvalid Option \e[0m"
                ;;

            esac
        done
        
}