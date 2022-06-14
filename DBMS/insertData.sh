#! /bin/bash

function insertData {
	# choose the table
	echo "Your Tables : "
	ls
	echo -e "-----------\n"
	read -p "Enter Table Name : " dbtable

	# not exist
	if ! [[ -f "$dbtable" ]]; then
		read -p "Table Not Exist, press any key ..."
	else
		# table exists
		insertData=true
		read -p "Enter New PK Value : " newPK
		while $insertData; do

			pk_used=$(cut -d ':' -f1 "$dbtable" | awk '{if(NR != 1) print $0}' | grep -x -e "$newPK")

			# null entry
			if [[ "$newPK" == '' ]]; then
				read -p "Primary Key can't be Empty, Try Again : " newPK

			# special characters
			elif [[ $newPK =~ [/.:\|\-] ]]; then
				read -p "Primary Key can't contain these characters => . / : - |, Try Again : " newPK

			#! if primary key exists
			elif ! [[ "$pk_used" == '' ]]; then
				read -p "This Primary Key is Used Before, Try Again : " newPK

			# primary key is valid
			else
				echo -n "$newPK" >>"$dbtable"
				echo -n ':' >>"$dbtable"

				# to get number of columns in table
				num_col=$(head -1 "$dbtable" | awk -F: '{print NF}')

				# to iterate over the columns after the primary key, in order to enter its data
				for ((i = 1; i < num_col; i++)); do

					# enter other data
					insertOtherCol=true

					read -p "Enter Value of Col. $((i + 1)) : " newValue

					while $insertOtherCol; do
						# not empty
						if [[ "$newValue" == '' ]]; then
							read -p "Value Can't be EMPTY, Try Again : " newValue

						# special characters
						elif [[ $newValue =~ [/.:\|\-] ]]; then
							read -p "Value can't contain these characters => . / : - |, Try Again : " newValue

						# valid value
						else
							# if last column
							if [[ i+1 -eq $num_col ]]; then
								echo "$newValue" >>"$dbtable"
								insertOtherCol=false
								insertData=false
							else
								# next column
								echo -n "$newValue": >>"$dbtable"
								insertOtherCol=false
							fi
						fi
					done
				done
			fi
		done
		read -p "Row Inserted Successfully, Press any key to Continue .."
	fi
}
