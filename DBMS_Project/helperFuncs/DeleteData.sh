#!/bin/bash

function deleteData {
    PS3=">>delete data: "
    read -e -p ">> Table name: " tablename

    if [ -f $tablename ]
    then
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
    echo "File Does not exist"

    fi
}