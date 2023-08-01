#!/usr/bin/bash

echo "^_^ Welcome to DB Main Menu ^_^"
PS3='Please select your choise: '

options=("Create DB" "List DBs" "Connect to DB" "Drop DB" "Exit")


select op in "${options[@]}"


do

    case $op  in 

        "Create DB")




            ;;
        "List DBs")
            
            ;;

        "Connect to DB")
            
            ;;

        "Drop DB")
           
            ;;

            "Exit")
            
            ;;

            *)
            echo "Invalid Option "
            ;;

    esac
done