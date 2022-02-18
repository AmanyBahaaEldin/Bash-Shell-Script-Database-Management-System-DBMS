#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

function insertIntoTable {
read -e -p ">> Table name: " tablename

if [ -f $tablename ]
    then
	header=`(sed -n '2p' $tablename)`
	IFS='|'
	read -a headarr <<< "$header"
	flag=1
	
	for field in ${headarr[@]}
	do
		IFS=':'
		read -a tmparr <<< "$field"
		read -e -p ">> Enter the ${tmparr[0]}: " value
		case ${tmparr[1]} in
		"int") while true
		do
		echo entered intcase
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
		echo "PK="$pkvalues
		if [[ $value != +([A-Za-z0-9]) ]]
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
		*) echo "default"
		;;
		esac
		flag=5
		echo -n $value"," >> $tablename
	done
	echo -n $'\n' >> $tablename
	echo "Data inserted successfully"
    else
	echo Table Doesnot exist
 fi
}
