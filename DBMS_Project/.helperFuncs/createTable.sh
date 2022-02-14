#!/bin/bash

function createTable {
    typeset -i N_col
    typeset -i iter
    read -e -p ">> Table name: " name
    read -e -p ">> Number of Columns: " N_col
    touch ."$name"'_metadata'
    echo "Table Name:"$name >> ."$name"'_metadata'
    echo "Number of Tables:"$N_col >> ."$name"'_metadata'

    iter=0
    while [ $iter -lt $N_col ]
    do
    let iter=$iter+1
    echo "Enter Col_Name and Datatype of col $iter: "
    read col_name col_type
    echo $col_name":"$col_type >> ."$name"'_metadata'
    
    done

    touch $name'.csv'
    
}