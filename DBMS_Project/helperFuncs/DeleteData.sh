#!/bin/bash

function deleteData {
    PS3=">>>> "
    read -e -p ">> Table name: " tablename

    if [ -f $tablename ]
    then
    select option in "all" "by primaryKey"
        do
        case $REPLY in
        1) sed -i '3,$d' $tablename
           ;;
        2) read -e -p ">> key: " val
           awk -F"," -v VARIABLE=$val '{ if($1!=VARIABLE) print }' $tablename > tmpfile && mv tmpfile $tablename
           ;;
         *) echo "Invalid Option"
           ;;
        esac
        done
    else
    echo "File Does not exist"

    fi
}