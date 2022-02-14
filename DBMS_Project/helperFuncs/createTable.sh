#!/bin/bash

function createTable {
    typeset -i N_col
    typeset -i iter
    # DataType_arr=(int string)
    
    read -e -p ">> Table name: " name
    
    if [ ! -f $name ]
    then
       #create table 
       touch $name
       echo "Table $name created successfully"

       read -e -p ">> Number of Columns: " N_col
       echo -n "Table Name:"$name >> $name
       echo  "|Number of Columns:"$N_col >> $name

       iter=0
       while [ $iter -lt $N_col ]
       do
       let iter=$iter+1
       echo "Enter Col_Name and Datatype of col $iter: "
       read col_name col_type
       
            while [[ $col_name == [0-9]* ]]
            do
            echo ">> invalid column name"
            read -e -p ">> Enter valid column name: " col_name
            done
            

            while [[ $col_type != int && $col_type != string ]]
            do
            echo ">> invalid column DataType"
            read -e -p ">> Enter valid column DataType: " col_type
            done

            echo -n $col_name":"$col_type"|" >> $name

       done
       echo -n $'\n' >> $name
       
    else
       echo "Table $name already exist"
    fi
    
}