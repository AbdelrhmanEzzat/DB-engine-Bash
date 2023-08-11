#!/bin/bash
#. /../../Methods/Table-methods.sh

echo "Welcome to Table Menu :)"
PS3='Enter your choice: '
options=("Create Table" "List Table" "Drop Table" "Insert into Table" "Select from Table" "Delete from Table" "Update Table" "Main menu")
select op in "${options[@]}"
do
    case $op in
        "Create Table")
            #PATH
            . ../../Table-Scripts/CreateT.sh

            ;;
        "List Table")
             . ../../Table-Scripts/ListT.sh
            

            ;;
        "Drop Table")
            . ../../Table-Scripts/DropT.sh

            ;;
        "Insert into Table")
            #PATH

            ;;
	    "Select from Table")
	        . ../../Table-Scripts/SelectT.sh

	    ;;
        "Delete from Table")
	       . ../../Table-Scripts/DeleteFromT.sh

	    ;;
	    "Update Table")
            #PATH

	    ;;
        "Main menu")
           cd ../.. # change your directory and excute the menu
           . DB-MainMenu.sh

            ;;
        *) echo "unavailable option $REPLY";;
    esac
done
