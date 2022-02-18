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
           awk -F"," -v VARIABLE=$val '{ if($1!=VARIABLE) print }' $tablename > tmpfile && mv tmpfile $tablename
           echo -e "\e[1;32m Data deleted successfully \e[0m\n"
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