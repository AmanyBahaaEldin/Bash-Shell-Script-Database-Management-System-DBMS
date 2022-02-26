#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

function insertIntoTable {
read -e -p ">> Table name: " tablename

if [ -z "$tablename" ]
then 
echo -e "\e[1;31m Please enter correct Table name ...\e[0m"
else
		if [ -f $tablename ]
			then
			header=`(sed -n '2p' $tablename)`
			IFS='|'
			read -a headarr <<< "$header"
			flag=1
			declare -a record
			typeset -i index=0
			for field in ${headarr[@]}
			do
				IFS=':'
				read -a tmparr <<< "$field"
				read -e -p ">> Enter the ${tmparr[0]}: " value
				
				case ${tmparr[1]} in
				"int") while true
				do
				if [ -z "$value" ]
				then
					if [[ $flag == 1 ]]
					then 
						echo -e "\e[1;31m Primary key must be not NULL \e[0m"
						read -e -p ">> Enter the ${tmparr[0]}: " value
						continue
					fi
				fi
				pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1 | grep "^${value}$"`
				
				if [[ $value != +([0-9]) ]]
				then
				read -e -p ">> Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
				continue
				fi
				
				if [[ ! (-z $pkvalues)  && $flag == 1 ]]
				then
				read -e -p ">> $value exists Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
				continue
				fi
				
				break
				done 
				;;
				"string") while true
				do
				if [ -z "$value" ]
				then
					if [[ $flag == 1 ]]
					then 
						echo -e "\e[1;31m Primary key must be not NULL \e[0m"
						read -e -p ">> Enter the ${tmparr[0]}: " value
						continue
					fi
				fi
				pkvalues=`sed '1,2d' $tablename |cut -d "," -f 1 | grep "^${value}$"`  
				if [[ $value != +([A-Za-z0-9]) ]]
				then
				read -e -p "Enter valid ${tmparr[0]} must be ${tmparr[1]}: " value 
				continue
				fi
				
				if [[ ! (-z $pkvalues) && $flag == 1 ]]
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
				record[index]=$value
				index=$index+1
				
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
fi
}
