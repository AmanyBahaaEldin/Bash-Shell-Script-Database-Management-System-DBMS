#!/bin/bash


function SelectData {
    PS3=">> select data: "
    read -e -p ">> Table name: " tablename
    if [ -f $tablename ]
    then
    typeset -i index=0
      header=`(sed -n '2p' $tablename)`
      IFS='|'
      read -a headarr <<< "$header"
      for field in ${headarr[@]}
         do
         IFS=':'
         read -a tmparr <<< "$field"
         headarr[index]=${tmparr[0]}
         index=$index+1
         done
        echo ${headarr[@]}
        select option in " All" " by primaryKey" "Back" "Exit"
        do
        case $REPLY in
        1) 
            echo "\n${headarr[@]}" | column -t
            echo "-----------------------------------------------------"
            sed '1,2d' $tablename | column -t -s "," 
           ;;
        2) read -e -p ">> key: " val
        echo "\n${headarr[@]}" | column -t
           echo | awk -F"," -v VARIABLE=$val '{ if(NR>=2 && $1==VARIABLE)  print $0 }' $tablename | column -t -s ","
           ;;
         3) clear
            DB_List $1
            ;;
         4) exit
         ;; 
         *) echo -e "\e[1;33m Invalid Option\e[0m"
           ;;
        esac
        done
   else
    echo -e "\e[1;33mFile Does not exist\e[0m"

    fi
}