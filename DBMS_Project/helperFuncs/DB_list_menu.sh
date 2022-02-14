#!/bin/bash


source $1/helperFuncs/createTable.sh       #$1 -> to can go to the path
function DB_List {
        echo -e "=============== $1 DB ====================== \n"    #$1 -> to change ps3 with database name
        COLUMNS=50
        PS3=$'\n'">> $1: "
        select option in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table"
        do
        case $REPLY in
        1) createTable
           ;;
        2) ls
           ;;
        3) read -e -p ">> Table name: " name
           rm $name
           ;;
         *) echo "Invalid Option"
           ;;
        esac
        done
}