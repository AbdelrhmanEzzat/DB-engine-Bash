#!/usr/bin/bash
. Color.sh

echo -e "\n \t\t\t ${MAGENTA}^_^ Welcome to DB Main Menu ^_^${NC}"
PS3=$(echo -e "${YELLOW}Please select your choice: ${NC}")

options=("Create DB" "List DBs" "Connect to DB" "Drop DB")


select op in "${options[@]}"


do

    case $op  in 

        "Create DB")

            . DB-Scripts/CreateDB.sh


            ;;
        "List DBs")
            if [ "$(ls Databases/ )" ]; then
            ls Databases

            else echo -e "\e[31mNo Databases to Display\e[0m"
            . DB-MainMenu.sh
            fi

            ;;

        "Connect to DB")

            . DB-Scripts/ConnectDB.sh
            
            ;;

        "Drop DB")

            . Methods/DB-methods.sh
            DropDB
           
            ;;

            *)
            echo -e "\e[31mInvalid Option\e[0m"
            . DB-MainMenu.sh

            ;;

    esac
done