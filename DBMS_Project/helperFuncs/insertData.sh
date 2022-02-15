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
	
	
	for field in ${headarr[@]}
	do
		IFS=':'
		read -a tmparr <<< "$field"
		read -e -p ">> Enter the ${tmparr[0]}: " value
		case ${tmparr[1]} in
		"int") while true
		do
		echo entered intcase
		pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1`  
		if [[ $value != +([0-9]) ]]
		then
		read -e -p ">> Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		continue
		fi
		
		for PK in $pkvalues
			do 
			echo $pkvalues
			if [[ $value == $PK ]]
			then 
			echo "value=$value"
			read -e -p ">> $value exists Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		    continue 2
			fi
			done
		break
		done 
		;;
		"string") while true
		do
		echo entered strcase
		pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1`  
		if [[ $value != +([A-Za-z0-9]) ]]
		then
		read -e -p ">> Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		continue
		fi
		
		for PK in $pkvalues
			do 
			echo $pkvalues
			if [[ $value == $PK ]]
			then 
			echo "value=$value"
			read -e -p ">> $value exists Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
		    continue 2
			fi
			done
		break
		done 
		# while [[ $value != +([A-Za-z0-9]) ]]
		# do
		# read -e -p ">> Enter valid ${tmparr[0]}: " value
		# done
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
