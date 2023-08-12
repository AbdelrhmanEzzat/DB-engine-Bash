#!/bin/bash
#. /../../Methods/Table-methods.sh

echo "Welcome to Table Menu :)"
PS3='Enter your choice From Table Main Menu: '
options=("Create Table" "List Table" "Drop Table" "Insert into Table" "Select from Table" "Delete from Table" "Update Table" "Main menu")
select op in "${options[@]}"
do
    case $op in
        "Create Table")
            
            . ../../Table-Scripts/CreateT.sh

            ;;
        "List Table")
             . ../../Table-Scripts/ListT.sh
            

            ;;
        "Drop Table")
            . ../../Table-Scripts/DropT.sh

            ;;
        "Insert into Table")
            . ../../Table-Scripts/InsertT.sh

            ;;
	    "Select from Table")
	        . ../../Table-Scripts/SelectT.sh

	    ;;
        "Delete from Table")
	       . ../../Table-Scripts/DeleteFromT.sh

	    ;;
	    "Update Table")
           . ../../Table-Scripts/UpdateT.sh

	    ;;
        "Main menu")
           cd ../.. # change your directory and excute the menu
           . DB-MainMenu.sh

            ;;
        *) echo "unavailable option $REPLY";;
    esac
done
