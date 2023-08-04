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
            if [ -e "Databases/$DBname" ]; then

                cd ./Databases/$DBname 
                pwd 
                echo "Connected to DB successfully"

                . ../../Table-Menu.sh
                
            fi          
            ;;

        "Main menu")
           
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


