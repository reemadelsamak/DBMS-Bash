#! /bin/bash

function deleteRow {
	##########
	# choose table
	echo "Your Tables : "
	ls
	echo -e "-----------\n"
	read -p "Choose Table : " dbtable

	##########
	# null entry
	if [[ "$dbtable" = '' ]]; then
		read -p "Table Name can't be EMPTY !!, press any key ..."

	############

	# table not exist
	elif ! [[ -f "$dbtable" ]]; then
		read -p "Table doesn't exist, press any key ..."

	else
		# table exists
		read -p "Enter Primary Key : " PK
		recordNum=$(cut -d ':' -f1 "$dbtable" | awk '{if(NR != 1) print $0}' | grep -x -n -e "$PK" | cut -d':' -f1)
		#! -x => exact match // -e => pattern // -n record number prefix

		# null entry
		if [[ "$PK" == '' ]]; then
			read -p "Primary Key can't be EMPTY !!, Try Again : " PK

		# record not exists
		elif [[ "$recordNum" = '' ]]; then
			read -p "Primary Key NOT Exist !!, Try Again : " PK

		# record exists
		else
			let recordNum=$recordNum+1 #!=> recordNum is 0 based but sed is 1 based
			sed -i "${recordNum}d" "$dbtable"
			echo -e "Record Deleted Successfully"
		fi
	fi
}
