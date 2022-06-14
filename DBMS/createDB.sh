#! /bin/bash

# create Database

function createDb {

	read -p "Enter new Database name : " dbname

	#############
	# null entry
	if [[ $dbname = "" ]]; then
		echo "Database Name can't be EMPTY !!"
		read -p "press any key ... "
	#############

	# special characters
	elif [[ $dbname =~ [/.:\|\-] ]]; then
		echo -e "Database Name can't contain these characters => . / : - |"
		read -p "press any key ... "

	#############
	# db name exists
	elif [[ -e $dbname ]]; then
		echo "Database already exists"
		read -p "press any key ... "

	#############
	# new DB
	elif [[ $dbname =~ ^[a-zA-Z] ]]; then
		mkdir -p "$dbname"
		cd "./$dbname"

		read -p "Database created sucessfully, press any key ..."
		dbsScreen=false
		tablesScreen=true

	#############
	else
		echo -e "Database Name can't start with numbers or special characters"
		read -p "press any key ... "
	fi
}
