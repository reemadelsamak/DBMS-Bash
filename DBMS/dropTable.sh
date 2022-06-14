#! /bin/bash

# delete table
function dropTable {
	echo "Your Tables : "
	ls
	echo -e "-----------\n"
	read -p "Enter Table Name : " dbtable
	############

	# null entry
	if [[ "$dbtable" = '' ]]; then
		read -p "Table Name can't be EMPTY !!, press any key ..."

	############
	
	# table not exist
	elif ! [[ -f "$dbtable" ]]; then
		read -p "Table doesn't exist, press any key ..."

	##########
	# table exists
	else
		rm "$dbtable"
		echo -e "$dbtable removed successfully"
		read
	fi
}
