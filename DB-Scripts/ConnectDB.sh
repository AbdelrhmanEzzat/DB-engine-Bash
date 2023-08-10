#!/usr/bin/bash



PS3=$(echo -e "${YELLOW}Please select your choice: ${NC}")

options=( "List DBs" "Connect to DB" "Main menu")


select op in "${options[@]}"


do

    case $op  in 

        "List DBs")

            if [ "$(ls Databases/ )" ]; then
            ls Databases

            else echo -e "\e[31mNo Databases to Display\e[0m"
            . DB-MainMenu.sh
            fi
            ;;
            
        "Connect to DB")
        
            . Methods/DB-methods.sh
            DB_Connection
            ;;

        "Main menu")

           #cd ..
           
           . DB-MainMenu.sh

            ;;


        *)

            echo "Invalid Option"
            ;;

    esac
done


