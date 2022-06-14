#! /bin/bash
welcomeScreen=true
dbsScreen=true
tablesScreen=true

while true; do
	# welcome screen
	while $welcomeScreen; do
		clear

		echo -e "\n*****\nBash Sript - DBMS Project - Mohamed AlWakiel & Reem Samak\n*****\n"
		echo -e "-----------"

		select choice in "Enter DBMS" "Exit"; do
			case $REPLY in
			1)
				if ! [[ -e $(pwd)/DBMS ]]; then
					mkdir -p ./DBMS
				fi
				cd ./DBMS/

				welcomeScreen=false
				dbsScreen=true
				echo -e "-----------"
				;;
			2)
				exit
				;;
			*)
				echo -e "Wrong Entry"
				;;
			esac
			break
		done

	done

	# Databases Screen
	while $dbsScreen; do
		clear
		echo -e "-----------"
		echo -e "Databases Menu: "
		echo -e "-----------"

		select choice in "Create Database" "List Database" "Connect Database" "Drop Database" "Back"; do
			case $REPLY in
			1) # Create Database
				echo -e "-----------"
				source ../createDb.sh
				createDb
				;;

			2) # List Database
				echo -e "-----------"
				echo -e "Database:\n"
				ls
				read
				;;

			3) # Connect Database
				echo -e "-----------"
				source ../connectDB.sh
				connectDB
				;;
			4) # Drop Database
				echo -e "-----------"
				source ../dropDB.sh
				dropDB
				;;
			5) # Back
				cd ..
				welcomeScreen=true
				dbsScreen=false
				tablesScreen=false
				;;

			*)
				read -p "Wrong Entry !, press any key ..."
				;;
			esac
			break
		done
	done

	#Tables Screen
	while $tablesScreen; do
		clear
		echo -e "-----------"
		echo -e "Tables Menu: "
		echo -e "-----------"

		select choice in "Create table" "List tables" "Drop table" "Insert into table" "Select from table" "Delete from table" "Update table" "Back"; do
			case $REPLY in
			1) # create table
				echo -e "-----------"
				source ../../createTable.sh
				createTable
				;;

			2) # List tables
				echo -e "-----------"
				echo -e "Tables:\n"
				ls
				read
				;;

			3) # Drop table
				echo -e "-----------"
				source ../../dropTable.sh
				dropTable
				;;

			4) # Insert into table
				echo -e "-----------"
				source ../../insertData.sh
				insertData
				;;

			5) # Select from Table
				echo -e "-----------"
				source ../../selectRow.sh
				selectRow
				;;

			6) # Delete from Table
				echo -e "-----------"
				source ../../deleteRow.sh
				deleteRow
				;;
			7) # Update table
				echo -e "-----------"
				source ../../updateTable.sh
				updateTable
				;;

			8) # back
				cd ..
				welcomeScreen=false
				dbsScreen=true
				tablesScreen=false
				;;
			*)
				read -p "Wrong Entry !, press any key ..."
				;;
			esac
			break
		done
	done
done
