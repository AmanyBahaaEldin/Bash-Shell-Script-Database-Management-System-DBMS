#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

function insertIntoTable {
read -e -p ">> Table name: " tablename

if [ -f $tablename ]
    then
	header=`(sed -n '2p' $tablename)`
	#echo $header
	IFS='|'
	read -a headarr <<< "$header"
	#echo ${headarr[@]}
	#echo ${#headarr[@]}
	typeset -i flag
	flag=0
	typeset -i exist=0
	pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1`  
	
	for field in ${headarr[@]}
	do
		IFS=':'
		read -a tmparr <<< "$field"
		read -e -p ">> Enter the ${tmparr[0]}: " value
		case ${tmparr[1]} in
		"int") while true
		do
		if [[ $value != +([0-9]) ]]
		then
		read -e -p ">> Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		continue
		fi
		for i in $pkvalues
			do 
			if [[ $value==$i ]]
			then 
			echo "value=$value"
			flag=1
			echo "Not Unique value ..."
			break 2
			fi
			done
		done 
		;;
		"string") while [[ $value != +([A-Za-z0-9]) ]]
		do
		read -e -p ">> Enter valid ${tmparr[0]}: " value
		done
		;;
		*) echo "default"
		;;
		esac
		flag=1
		echo -n $value"," >> $tablename
	done
	echo -n $'\n' >> $tablename
	echo "Data inserted successfully"
	#awk -F"| {if(NR==2) for ( i=1; i<NF; i++) print $i | } $tablename
    else
	echo Table Doesnot exist
 fi
}
