#! /bin/bash

function selectRow {
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

	##########
	else
		# table exists
		read -p "Enter Primary Key : " PK
		recordNum=$(cut -d ':' -f1 "$dbtable" | sed '1d'\  | grep -x -n -e "$PK" | cut -d':' -f1)

		# null entry
		if [[ "$PK" == '' ]]; then
			read -p "Primary Key can't be EMPTY !!, Try Again : " PK

		# record not exists
		elif [[ "$recordNum" = '' ]]; then
			read -p "Primary Key NOT Exist !!, Try Again : " PK

		# record exists
		else
			let recordNum=$recordNum+1
			num_col=$(head -1 "$dbtable" | awk -F: '{print NF}')

			# to show the other values of record
			echo -e "Data of this Row : "
			for ((i = 2; i <= num_col; i++)); do
				echo \"$(head -1 $dbtable | cut -d ':' -f$i | awk -F "-" 'BEGIN { RS = ":" } {print $1}')\" : $(sed -n "${recordNum}p" "$dbtable" | cut -d: -f$i)
			done
		fi
		read -p "Success!, press any key ..."
	fi
}
