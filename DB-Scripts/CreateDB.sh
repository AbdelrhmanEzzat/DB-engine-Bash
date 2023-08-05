#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob



PS3='Please select your choise: '

options=("Create DB" "List DBs" "Main menu" "Exit")


select op in "${options[@]}"


do

    case $op  in 

        "Create DB")

            read -p "Enter New DataBase Name : " DBname

            #
            . Methods/DB-methods.sh
            createDB_Name


            ;;
        "List DBs")
        
            ls Databases
            
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


