#!/bin/bash


source $1/helperFuncs/createTable.sh       #$1 -> to can go to the path
source $1/helperFuncs/insertData.sh
source $1/helperFuncs/selectData.sh
source $1/helperFuncs/DeleteData.sh
function DB_List {
        dataBaseDIR=`pwd`/DataBases
        echo -e "=============== $1 DB ====================== \n"    #$1 -> to change ps3 with database name
        COLUMNS=50
        PS3=$'\n'">> $1: "
        select option in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Back" "Exit"
        do
        case $REPLY in
        1) createTable
           ;;
        2) ls
           ;;
        3) read -e -p ">> Table name: " name
           rm $name
           ;;
	     4) insertIntoTable
	        ;;
         5) SelectData
           ;;
         6) deleteData
           ;; 
         7) clear
         mainDBMSMenu $dataBaseDIR
         ;;
         8) exit
         ;;
         *) echo "Invalid Option"
           ;;
        esac
        done
}
