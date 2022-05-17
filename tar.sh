#!/bin/bash
 
# Read the command
read alpha

# Setting IFS (input field separator) value as " "
IFS=' '

# Reading the split input into array
read -ra arr <<< "$alpha"

if [ ${#arr[@]} -lt 3 ];
then
	printf "Give full commands.\n"
	exit
fi
# Validation check for tar
if [[ "${arr[0]}" = "tar" ]];
then
	# Executing -cf or -rf
	if [[ "-cf" = "${arr[1]}" || "-rf" = "${arr[1]}" ]];
	then
		for ((i=3;i<${#arr[@]};i++))
		do
			if [[ ${arr[i]:0:2} == "*." ]];
			then
              			IFS=$'\n'
              			str=$(ls ${arr[$i]})
              			read -rd '' -a arr1 <<<"$str"		
				for val in "${arr1[@]}";
	      			do
                   		cat $val >> ${arr[2]}
                   		echo "$val" &>> metadata.txt
						wc -l < ${arr[2]} &>> metadata.txt
						ls -l | grep "$val" &>> metadata.txt
              		done
				continue
			fi
			if [ -e ${arr[$i]} ];
			then
				cat ${arr[$i]} &>> ${arr[2]}
				echo ${arr[$i]} &>> metadata.txt
				wc -l < ${arr[2]} &>> metadata.txt
				ls -l | grep ${arr[$i]} &>> metadata.txt
			else
				printf "FILE DOES NOT EXIST!\n"
			fi
		done
	# Executing -cvf or -rvf
	elif [[ "${arr[1]}" = "-cvf" || "${arr[1]}" = "-rvf" ]];
	then
		for ((i=3;i<${#arr[@]};i++))
		do
			if [[ ${arr[i]:0:2} == "*." ]];
			then
              			IFS=$'\n'
              			str=$(ls ${arr[$i]})
              			read -rd '' -a arr1 <<<"$str"		
				for val in "${arr1[@]}";
	      			do
                   		cat $val >> ${arr[2]}
                   		echo "$val" &>> metadata.txt
						wc -l < ${arr[2]} &>> metadata.txt
						ls -l | grep "$val" &>> metadata.txt
						printf "$val\n"
              		done
				continue
			fi
			if [ -e ${arr[$i]} ];
			then
				cat ${arr[$i]} &>> ${arr[2]}
				echo ${arr[$i]} &>> metadata.txt
				wc -l < ${arr[2]} &>> metadata.txt
				ls -l | grep ${arr[$i]} &>> metadata.txt
				printf "${arr[$i]}\n"
			else
				printf "FILE DOES NOT EXIST!\n"
			fi
		done
	# Executing -tvf
	elif [[ "${arr[1]}" = "-tvf" ]];
	then
		if [ -e ${arr[2]} ];
		then
			sed -n 0~3p metadata.txt
		else
			printf "FILE DOES NOT EXIST!\n"
		fi
	# Executing -tf
	elif [[ "${arr[1]}" = "-tf" ]];
	then
		if [ -e ${arr[2]} ];
		then
			sed -n 1~3p metadata.txt
		else
			printf "FILE DOES NOT EXIST!\n"
		fi
	# Executing -xf
	elif [[ "${arr[1]}" = "-xf" ]];
	then
		if [ -e ${arr[2]} ];
		then
		if [ ${#arr[@]} -eq 3 ];
		then
			IFS=$'\n'
			arr1=($(sed -n 1~3p metadata.txt))
			for ((i=0;i<${#arr1[@]};i++))
			do
				str="`grep -n ${arr1[$i]} metadata.txt`"
				if [ -z "$str" ]
				then
					printf "FILE TO BE EXTRACT NOT FOUND!\n "
					continue
				fi
				IFS=':'
				read -ra line <<< "$str"
				r1=$(( ${line[0]} - 2 ))
				r2=$(( ${line[0]} + 1 ))
				if [ $r1 -lt 0 ];
				then
					count1=0
				else
				count1=`cat metadata.txt | head -$r1 | tail -1`
				fi
				count1=$((count1+1))
				count2=`cat metadata.txt | head -$r2 | tail -1`
				sed -n "$count1,$count2 p" ${arr[2]} > ${arr1[$i]}
			done
			
		else
			for ((i=3;i<${#arr[@]};i++))
			do
				str="`grep -n ${arr[$i]} metadata.txt`" 
				if [ -z "$str" ]
				then
					printf "FILE TO BE EXTRACT NOT FOUND!\n "
					continue
				fi
				IFS=':'
				read -ra line <<< "$str"
				r1=$(( ${line[0]} - 2 ))
				r2=$(( ${line[0]} + 1 ))
				if [ $r1 -lt 0 ];
				then
					count1=0
				else
				count1=`cat metadata.txt | head -$r1 | tail -1`
				fi
				count1=$((count1+1))
				count2=`cat metadata.txt | head -$r2 | tail -1`
				sed -n "$count1,$count2 p" ${arr[2]} > ${arr[$i]}
			done
		fi
		else
		printf "FILE DOES NOT EXIST!\n"
		fi
	# Executing -xvf
	elif [[ "${arr[1]}" = "-xvf" ]];
	then
		if [ -e ${arr[2]} ];
		then
		if [ ${#arr[@]} -eq 3 ];
		then
			IFS=$'\n'
			arr1=($(sed -n 1~3p metadata.txt))
			for ((i=0;i<${#arr1[@]};i++))
			do
				str="`grep -n ${arr1[$i]} metadata.txt`" 
				if [ -z "$str" ]
				then
					printf "FILE TO BE EXTRACT NOT FOUND!\n "
					continue
				fi
				printf "${arr1[$i]}\n"
				IFS=':'
				read -ra line <<< "$str"
				r1=$(( ${line[0]} - 2 ))
				r2=$(( ${line[0]} + 1 ))
				if [ $r1 -lt 0 ];
				then
					count1=0
				else
				count1=`cat metadata.txt | head -$r1 | tail -1`
				fi
				count1=$((count1+1))
				count2=`cat metadata.txt | head -$r2 | tail -1`
				sed -n "$count1,$count2 p" ${arr[2]} > ${arr1[$i]}
			done
			
		else
			for ((i=3;i<${#arr[@]};i++))
			do
				str="`grep -n ${arr[$i]} metadata.txt`"
				if [ -z "$str" ]
				then
					printf "FILE TO BE EXTRACT NOT FOUND!\n "
					continue
				fi
				printf "${arr[$i]}\n" 
				IFS=':'
				read -ra line <<< "$str"
				r1=$(( ${line[0]} - 2 ))
				r2=$(( ${line[0]} + 1 ))
				if [ $r1 -lt 0 ];
				then
					count1=0
				else
				count1=`cat metadata.txt | head -$r1 | tail -1`
				fi
				count1=$((count1+1))
				count2=`cat metadata.txt | head -$r2 | tail -1`
				sed -n "$count1,$count2 p" ${arr[2]} > ${arr[$i]}
			done
		fi
		else
		printf "FILE DOES NOT EXIST!\n"
		fi
	# Validation checks on flags
	else
		printf "Incorrect command.\n"
	fi
# Printing error in case 'tar' is not written 
else
printf "Incorrect command.\n"
fi
