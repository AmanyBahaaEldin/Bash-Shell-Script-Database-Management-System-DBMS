#!/bin/bash

function deleteData {
    
    read -e -p ">> Table name: " tablename
    
    if [ -z "$tablename" ]
    then 
    echo -e "\e[1;31m Please enter correct Table name ...\e[0m"
    else
         if [ -f $tablename ]
         then
         PS3=">>delete data: "
         select option in " All" " by primaryKey" "Back" "Exit" 
            do
            case $REPLY in
            1) sed -i '3,$d' $tablename
            echo -e "\e[1;32m Data deleted successfully \e[0m\n"
               ;;
            2) read -e -p ">> key: " val
                  if [ -z "$val" ]
                  then 
                  echo -e "\e[1;31m the key must not be empty ...\e[0m"
                  else
                     var=`sed '1,2d' $tablename |cut -d "," -f 1 | grep $val`
                     if [ -z "$var" ] 
                     then 
                     echo -e "\e[1;31m the key does not exist ...\e[0m"
                     else
                     awk -F"," -v VARIABLE=$val '{ if($1!=VARIABLE) print }' $tablename > tmpfile && mv tmpfile $tablename
                     echo -e "\e[1;32m Data deleted successfully \e[0m\n"
                     fi
                  fi
               ;;
            3) clear
            DB_List $1
            ;;
            4) exit
            ;;
               *) echo "Invalid Option"
               ;;
            esac

            done
         else
         echo -e "\e[1;31mTable Does not exist\e[0m"

         fi
   fi
}