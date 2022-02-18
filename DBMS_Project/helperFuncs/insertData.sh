#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

function insertIntoTable {
read -e -p ">> Table name: " tablename

if [ -f $tablename ]
    then
	header=`(sed -n '2p' $tablename)`
	declare -a record
	IFS='|'
	read -a headarr <<< "$header"
	flag=1
	typeset -i index=0
	for field in ${headarr[@]}
	do
		IFS=':'
		read -a tmparr <<< "$field"
		read -e -p ">> Enter the ${tmparr[0]}: " value
		case ${tmparr[1]} in
		"int") while true
		do
		pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1 | grep $value`  
		if [[ $value != +([0-9]) ]]
		then
		read -e -p ">> Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		continue
		fi

		if [[ $value == $pkvalues && $flag == 1 ]]
		then
		read -e -p ">> $value exists Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		continue
		fi
		
		break
		done 
		;;
		"string") while true
		do
		pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1 | grep $value`  
		if [[ $value != +([A-Za-z0-9]) ]]
		then
		read -e -p "\e[1;31m>> Enter valid ${tmparr[0]} must be ${tmparr[1]}: \e[0m" value 
		continue
		fi
		
		if [[ $value == $pkvalues && $flag == 1 ]]
		then
		read -e -p "\e[1;31m>> $value exists Enter valid ${tmparr[0]} must be ${tmparr[1]}: \e[0m" value 
		continue
		fi
		break
		done 
		;;
		*) echo "default"
		;;
		esac
		flag=5
		record[index]=$value
		index=$index+1
		echo "record array : ${record[@]}"
	done
	for item in ${record[@]}
	do
	echo -n $item"," >> $tablename
	done
	echo -n $'\n' >> $tablename
	echo -e "\e[1;32m Data inserted successfully \e[0m"
    else
	echo -e "\e[1;31m $name table doesn't exist \e[0m"
 fi
}
