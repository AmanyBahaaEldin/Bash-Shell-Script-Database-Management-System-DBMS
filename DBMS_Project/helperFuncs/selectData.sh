#!/bin/bash


function SelectData {
    PS3="select data>> "
    read -e -p ">> Table name: " tablename
    
        select option in "all" "by primaryKey"
        do
        case $REPLY in
        1) sed '1,2d' $tablename | column -t -o "|" -s ","
           ;;
        2) read -e -p ">> key: " val
           echo | awk -F"," -v VARIABLE=$val '{ if(NR>=2 && $1==VARIABLE)  print $0 }' $tablename | column -t -o "|" -s ","
           ;;
         *) echo "Invalid Option"
           ;;
        esac
        done

}