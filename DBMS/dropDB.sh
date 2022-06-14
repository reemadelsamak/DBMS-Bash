#! /bin/bash

function dropDB {
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
		rm -rf "$db"
		echo -e "$db removed successfully"
		read
	fi

}
