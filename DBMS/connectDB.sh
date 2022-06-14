#! /bin/bash

function connectDB {

	echo "Your Databases : "
	ls  
	echo -e "-----------\n"
	read -p "Enter Database Name : " db
	
	############
	# null entry
	if [[ "$db" = '' ]]; then
		read -p "Database Name can't be EMPTY !!, press any key ..."

	############
	# db not exists
	elif ! [[ -d "$db" ]]; then
		read -p "Database doesn't exist, press any key ..."

	############
	# db exists
	else
		cd "$db"
		echo -e "-----------"
		dbsScreen=false
		tablesScreen=true
	fi

}
