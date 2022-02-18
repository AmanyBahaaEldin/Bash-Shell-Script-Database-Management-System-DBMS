#!/bin/bash

function createTable {
    typeset -i N_col
    typeset -i iter
    
    read -e -p ">> Enter Table name: " name
    
    if [ ! -f $name ]
    then
       typeset -i index=0
      declare -a record
       read -e -p ">> Number of Columns: " N_col

       iter=0
       while [ $iter -lt $N_col ]
       do
       let iter=$iter+1
       echo "Enter Col_Name and Datatype of col $iter: "
       read col_name col_type
       
            while [[ $col_name == [0-9]* ]]
            do
            echo -e "\e[1;31m invalid column name \e[0m\n"
            read -e -p ">> Enter valid column name: " col_name
            done
            
            while [[ $col_type != int && $col_type != string ]]
            do
            echo -e "\e[1;31m invalid column DataType \e[0m \n"
            read -e -p ">> Enter valid column DataType: " col_type
            done
            
            record[index]=$col_name":"$col_type"|"
            index=$index+1

       done
       touch $name
       echo -n "Table Name:"$name >> $name
       echo  "|Number of Columns:"$N_col >> $name
       for item in ${record[@]}
         do
         echo -n $item >> $name
         done
       echo -n $'\n' >> $name
       echo -e "\e[1;32mTable $name created successfully \e[0m\n"
       
    else
       echo -e "\e[1;33m Table $name already exist \e[0m"
    fi
    
}