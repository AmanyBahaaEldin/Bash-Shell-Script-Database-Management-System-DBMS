#!/bin/bash


function SelectData {
    
    read -e -p ">> Table name: " tablename
    if [ -z "$tablename" ]
    then 
    echo -e "\e[1;31m Please enter correct Table name ...\e[0m"
    else
         if [ -f $tablename ]
         then
            PS3=">> select data: "
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
            select option in " All" " by primaryKey" "Back" "Exit"
            do
            case $REPLY in
            1) 
                  echo $'\n'${headarr[@]} | column -t  -o "   |   "
                  echo "-----------------------------------------------------"
                  sed '1,2d' $tablename | column -t -s "," -o "   |   " 
               ;;
            2) read -e -p ">> key: " val
            
            if [ -z "$val" ]
            then 
            echo -e "\e[1;31m the key must not be empty ...\e[0m"
            else 
               var=`sed '1,2d' $tablename |cut -d "," -f 1 | grep $val`
               if [ -z "$var" ]
               then
               echo "Not existed key... try again"
               else
               echo "${headarr[@]}" | column -t -o "  |   "
               echo "-----------------------------------------------------"
               echo | awk -F"," -v VARIABLE=$val '{ if(NR>=2 && $1==VARIABLE)  print $0 }' $tablename | column -t -s "," -o "   |   "
               fi
            fi
               ;;
               3) clear
                  DB_List $1
                  ;;
               4) exit
               ;; 
               *) echo -e "\e[1;31m Invalid Option\e[0m"
               ;;
            esac
            done
         else
         echo -e "\e[1;31mTable Does not exist\e[0m"
         fi
   fi
}