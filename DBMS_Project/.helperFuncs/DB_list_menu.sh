#!/bin/bash

source ./.helperFuncs/createTable.sh
function DB_List {
        echo -e "=============== $1 DB ====================== \n"
        COLUMNS=50
        PS3=$'\n'">> $1: "
        select option in " Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table"
        do
        case $REPLY in
        1) createTable
           ;;
        2) ls
           ;;
        3) read -e -p ">> Table name: " name
           rm $name
           ;;
        esac
        done
}