#!/bin/bash
echo "Welcome to Table Menu :)"
PS3='Enter your choice: '
options=("Create Table" "List Table" "Drop Table" "Insert into Table" "Select from Table" "Delete from Table" "Update Table" "Exit")
select op in "${options[@]}"
do
    case $op in
        "Create Table")
            #PATH

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
        "Exit")
            break

            ;;
        *) echo "unavailable option $REPLY";;
    esac
done