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
	typeset -i flag=0
	for field in ${headarr[@]}
	  do
		IFS=':'
		read -a tmparr <<< "$field"
		echo ${tmparr[@]}
		echo ${#tmparr[@]}
		read -e -p ">> Enter the ${tmparr[0]}: " value
		case ${tmparr[1]} in
		"int") while [[ $value != +([0-9]) ]]
		do
		read -e -p ">> Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value
		  if [[ flag == 0 ]]
		  then
			while [[  
		  fi
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
		echo -n $value"," >> $tablename
	  done
	  echo -n $'\n' >> $tablename
	  echo "Data inserted successfully"
	#awk -F"| {if(NR==2) for ( i=1; i<NF; i++) print $i | } $tablename
    else
	echo Table Doesnot exist
fi
}
