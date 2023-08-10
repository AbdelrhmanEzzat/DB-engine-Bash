#!/bin/bash
. ../../Methods/Table-methods.sh

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
             #PATH
            

            ;;
        "Drop Table")
            #PATH

            ;;
        "Insert into Table")
            #PATH

            ;;
	    "Select from Table")
	        #PATH

	    ;;
        "Delete from Table")
	        #PATH

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
