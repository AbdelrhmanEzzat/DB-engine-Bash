#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob



PS3=$(echo -e "${YELLOW}Please select your choice: ${NC}")

options=("Create DB" "List DBs" "Main menu")


select op in "${options[@]}"


do

    case $op  in 

        "Create DB")


            #
            . Methods/DB-methods.sh
            createDB_Name


            ;;
       "List DBs")

            if [ "$(ls Databases/ )" ]; then
            ls Databases

            else echo -e "\e[31mNo Databases to Display\e[0m"
            
            . DB-Scripts/CreateDB.sh
            
            fi
            ;;

        "Main menu")
           
           . DB-MainMenu.sh

            ;;

            *)
            echo "Invalid Option "
            ;;

    esac
done


