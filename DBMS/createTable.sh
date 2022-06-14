#! /bin/bash

# Create Table & its metadata
function createTable {

	read -p "Enter new Table name : " dbtable

	#############
	# null entry
	if [[ $dbtable = "" ]]; then
		read -p "Table Name can't be EMPTY !!, press any key ..."

	#############
	# special characters
	elif [[ $dbtable =~ [/.:\|\-] ]]; then
		read -p "Table Name can't contain these characters => . / : - , press any key ..."

	#############
	# table name exists
	elif [[ -e "$dbtable" ]]; then
		read -p "Table already exists !, press any key ..."

	#############
	# new table
	elif [[ $dbtable =~ ^[a-zA-Z] ]]; then
		touch "$dbtable"
		source ../../tableInfo.sh
		tableInfo
		read
	else
		read -p "Table Name can't start with numbers or special characters !, press any key ..."

	fi
}
