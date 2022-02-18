#!/bin/bash


source $1/helperFuncs/createTable.sh       #$1 -> to can go to the path
source $1/helperFuncs/insertData.sh
source $1/helperFuncs/selectData.sh
source $1/helperFuncs/DeleteData.sh
function DB_List {
        
        echo -e "\e[1;34m\n =============== $1 DB ====================== \e[0m\n"    #$1 -> to change ps3 with database name
        COLUMNS=50
        PS3=$'\n\u001b[31m'">> $1: "$'\u001b[0m'
        select option in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Back" "Exit"
        do
        case $REPLY in
        1) createTable
           ;;
        2) ls
           ;;
        3) read -e -p ">> Table name: " name
         if [ -f $name ]
         then
           rm $name
           echo -e "\e[1;32m $name table dropped successfully \e[0m"
         else 
         echo -e "\e[1;31m $name table doesn't exist \e[0m"
         fi
           ;;
	     4) insertIntoTable
	        ;;
         5) SelectData $1
           ;;
         6) deleteData $1
           ;; 
         7) clear;
         cd ../../ ;
         dataBaseDIR=`pwd`/DataBases;
         mainDBMSMenu $dataBaseDIR
         ;;
         8) exit
         ;;
         *) echo -e "\e[1;31m Invalid Option\e[0m\n"
           ;;
        esac
        done
}
