#!/usr/bin/bash



PS3='Please select your choise: '

options=( "List DBs" "Connect to DB" "Main menu" "Exit")


select op in "${options[@]}"


do

    case $op  in 

        "List DBs")

            ls Databases


            ;;
        "Connect to DB")
        
            read -p "Enter DB name :" DBname
         #         
            . Methods/DB-methods.sh
            DB_Connection
            ;;

        "Main menu")

           #cd ..
           
           . DB-MainMenu.sh

            ;;

            "Exit")
            
                break
            ;;


            *)
            echo "Invalid Option "
            ;;

    esac
done


