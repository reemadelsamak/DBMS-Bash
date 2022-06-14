#! /bin/bash

function updateTable {
	# choose table
	echo "Your Tables : "
	ls
	echo -e "-----------\n"
	read -p "Enter Table Name : " dbtable

	# not exist
	if ! [[ -f "$dbtable" ]]; then
		read -p "Table Not Exist, press any key ..."
	else
		# table exists
		read -p "Enter Primary Key : " PK
		recordNum=$(cut -d ':' -f1 "$dbtable" | sed '1d' | grep -x -n -e "$PK" | cut -d':' -f1)

		# null entry
		if [[ "$PK" == '' ]]; then
			read -p "Primary Key can't be EMPTY !!, Try Again : " PK

		# record not exists
		elif [[ "$recordNum" = '' ]]; then
			read -p "Primary Key NOT Exist !!, Try Again : " PK

		# record exists
		else
			let recordNum=$recordNum+1
			# to get number of columns in table
			num_col=$(head -1 "$dbtable" | awk -F: '{print NF}')

			# to show the other fields' names of this record
			echo -e "Row Fields : "
			option=$(head -1 $dbtable | awk 'BEGIN{ RS = ":"; FS = "-" } {print $1}')
			echo "$option"
			getFieldName=true
			while $getFieldName; do
				read -p "Enter Field Name to Update : " fieldName

				# null entry
				if [[ "$fieldName" = '' ]]; then
					read -p "Field Name can't be Empty, Try Again : " fieldName

				# field name not exists
				elif [[ $(echo "$option" | grep -x "$fieldName") = "" ]]; then
					read -p "Field Name NOT Exist !! : " fieldName

				# field name exists
				else
					# get field number
					fieldnum=$(head -1 "$dbtable" | awk 'BEGIN{ RS = ":"; FS = "-" } {print $1}' | grep -x -n "$fieldName" | cut -d: -f1)
					update_Field=true
					while $update_Field; do
						# updating field's primary key
						if [[ "$fieldnum" = 1 ]]; then
							read -p "Enter New PK Value	: " newPK
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

							# pk is valid
							else
								awk -v fn="$fieldnum" -v rn="$recordNum" -v nv="$newPK" \
									'BEGIN { FS = OFS = ":" } { if(NR == rn)	$fn = nv } 1' "$dbtable" \
									>"$dbtable".new && rm "$dbtable" && mv "$dbtable".new "$dbtable"
								update_Field=false
								getFieldName=false
							fi

						# update other
						else
							update_other=true
							while $update_other; do
								read -p "Enter New Value : " otherNewValue

								if [[ "$otherNewValue" == '' ]]; then
									read -p "Value Can't be EMPTY, Try Again : " otherNewValue

								# special characters
								elif [[ $otherNewValue =~ [/.:\|\-] ]]; then
									read -p "Value can't contain these characters => . / : - |, Try Again : " otherNewValue

								# entry is valid
								else
									awk -v fn="$fieldnum" -v rn="$recordNum" -v nv="$otherNewValue" \
										'BEGIN { FS = OFS = ":" } { if(NR == rn)	$fn = nv } 1' "$dbtable" \
										>"$dbtable".new && rm "$dbtable" && mv "$dbtable".new "$dbtable"
									update_other=false
									getFieldName=false
								fi
							done
						fi
					done
					echo -e "Successful Update"
				fi
			done
		fi
	fi
}
