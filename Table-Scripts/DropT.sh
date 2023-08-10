#!/usr/bin/bash
echo "Drop Table"
read -p "Enter Database name " DBname
# DB validation 

PS3='Enter your choice: '

options=("List Tables" "Drop Table" "Table Main Menu"  "Exit")
select op in "${options[@]}"
do
    case $op in
        "List Tables")
            ls    

            ;;
        "Drop Table")
            read -p "Enter Table Name : " Tablename #DB validation 
            if [ -e ../Databases/$DBname/$Tablename ]; then
                    rm ../Databases/$DBname/$Tablename
		    echo "Table Dropped Successfully"

            else
                    echo "Table Not Found"
            fi

            ;;
        "Table Main Menu")
            bash ./Table-Menu.sh

            ;;
        "Exit")
            break

            ;;
        *) echo "not available option $REPLY";;
    esac
done