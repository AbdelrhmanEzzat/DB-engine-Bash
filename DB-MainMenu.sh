#!/usr/bin/bash

echo "^_^ Welcome to DB Main Menu ^_^"
PS3='Please select your choise: '

options=("Create DB" "List DBs" "Connect to DB" "Drop DB" "Exit")


select op in "${options[@]}"


do

    case $op  in 

        "Create DB")

            . DB-Scripts/CreateDB.sh


            ;;
        "List DBs")

            ls Databases
            
            ;;

        "Connect to DB")

            . DB-Scripts/ConnectDB.sh
            
            ;;

        "Drop DB")

            . DB-Scripts/DropDB.sh
           
            ;;

            "Exit")
            
            ;;

            *)
            echo "Invalid Option "
            ;;

    esac
done