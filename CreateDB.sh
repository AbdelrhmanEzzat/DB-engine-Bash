#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob

#Function to check for the input syntax and file is exist or not ;

createDB_Name() {
   
    if [[ $DBname =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then 

            if [[ -e "Databases/$DBname" ]]; then 

                echo "Database already exists"

            else
                mkdir "Databases/$DBname"
                echo " Database Successfully created ^_^ "
                pwd
            fi
            
    else  
        echo -e "\n Please Enter A Vaild Name (only letters preferred) "  # -e -->enables the interpretation of backslash escapes
        read -p "Enter DataBase name you want to create : " DBname # -p -->option is used to display a prompt before reading the input.

    fi 

}

PS3='Please select your choise: '

options=("Create DB" "List DBs" "Main menu" "Exit")


select op in "${options[@]}"


do

    case $op  in 

        "Create DB")

            read -p "Enter New DataBase Name : " DBname

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


