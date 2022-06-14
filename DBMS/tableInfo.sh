#! /bin/bash

# create tables info

function tableInfo {
    # create the table info
    if [[ -f "$dbtable" ]]; then
        # num of cols
        #validMetaData=true
        colsCorrect=true
        read -p "Enter Number of Columns : " num_col
        while $validMetaData; do
            if [[ "$num_col" = +([1-9])*([0-9]) ]]; then #2x0
                validMetaData=false
            else
                read -p "Wrong Number, Enter valid number : " num_col
            fi
        done
        ##########

        # pk name
        pkCorrect=true
        read -p "Enter Primary Key Name : " pk_name
        while $pkCorrect; do
            #############
            # null entry
            if [[ $pk_name = "" ]]; then
                echo -e "Primary Key can't be EMPTY !!"

            # special characters
            elif [[ $pk_name =~ [/.:\|\-] ]]; then
                echo -e "Primary Key can't contain these characters  => . / : - |"

            # correct entry
            elif [[ $pk_name =~ ^[a-zA-Z] ]]; then
                echo -n "$pk_name" >>"$dbtable"
                echo -n "-" >>"$dbtable"
                pkCorrect=false

            # numbers or other special characters
            else
                echo -e "Primary key can't start with numbers or special characters"
            fi
        done

        # pk dataType
        pk_typeCorrect=true
        echo -e "Choose PK Datatype : "
        while $pk_typeCorrect; do
            select choice in "Integer" "Varchar"; do
                if [[ "$REPLY" = "1" || "$REPLY" = "2" ]]; then
                    echo -n "$choice" >>"$dbtable"
                    echo -n "-" >>"$dbtable"
                    pk_typeCorrect=false
                else
                    echo -e "Wrong Entry, Try again ..."
                fi
                break
            done
        done

        # pk size
        pk_sizeCorrect=true
        read -p "Enter size of PK Column : " size
        while $pk_sizeCorrect; do
            if [[ "$size" = +([1-9])*([0-9]) ]]; then
                echo -n "$size" >>"$dbtable"
                echo -n ":" >>"$dbtable"
                pk_sizeCorrect=false
            else
                read -p "Wrong Number, Enter valid number : " size
            fi
        done

        ##########
        ## to iterate over the enterd num of columns after the primary key
        for ((i = 1; i < num_col; i++)); do
            ##########
            # field name
            correctName=true
            read -p "Enter Column $((i + 1)) name : " col_name
            while $correctName; do
                # null entry
                if [[ $col_name = "" ]]; then
                    echo -e "Column name can't be EMPTY !!"
                #############

                # special characters
                elif [[ $col_name =~ [/.:\|\-] ]]; then
                    echo -e "Column name can't contain these characters  => . / : - |"

                ############

                # correct entry
                elif [[ $col_name =~ ^[a-zA-Z] ]]; then
                    echo -n "$col_name" >>"$dbtable"
                    echo -n "-" >>"$dbtable"
                    correctName=false
                #############

                # numbers or other special characters
                else
                    echo -e "Column name can't start with numbers or special characters"
                fi
            done

            ##########
            # field dataType
            correctDatatype=true
            echo -e "Choose Column $((i + 1)) Datatype : "
            while $correctDatatype; do
                select choice in "integer" "varchar" "date" "bool"; do
                    if [[ "$REPLY" = "1" || "$REPLY" = "2" || "$REPLY" = "3" || "$REPLY" = "4" ]]; then
                        echo -n "$choice" >>"$dbtable"
                        echo -n "-" >>"$dbtable"
                        correctDatatype=false
                    else
                        echo -e "Wrong Entry, Try again ..."
                    fi
                    break
                done
            done

            ##########
            # field size
            correctSize=true
            read -p "Enter Size of Column $((i + 1)) : " size

            while $correctSize; do
                if [[ "$size" = +([1-9])*([0-9]) ]]; then
                    echo -n "$size" >>"$dbtable"
                    ##########
                    # if last column
                    if [[ i -eq $num_col-1 ]]; then
                        echo $'\n' >>"$dbtable"
                        read -p "table created successfully , press any key ..."

                    ##########
                    # next column
                    else
                        echo -n ":" >>"$dbtable"
                    fi
                    correctSize=false
                else
                    read -p "Wrong Number, Enter valid number : " size
                fi
            done
            ##########
        done
        ##########
    else
        read -p "Wrong Table Name !, press any key ..."
    fi
}
