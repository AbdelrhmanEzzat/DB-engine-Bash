#!/usr/bin/bash

#Function to check for the input syntax and file is exist or not ;

createDB_Name() {
   while (true)
   do
    if [[ $DBname =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then 

            if [[ -e "Databases/$DBname" ]]; then 

                echo "Database already exists"

            else
                mkdir "Databases/$DBname"
                echo " Database Successfully created ^_^ "
                pwd
            fi
                break
            
    else  
        echo -e "\n Please Enter A Vaild Name (only letters preferred) "  # -e -->enables the interpretation of backslash escapes
        read -p "Enter DataBase name you want to create : " DBname # -p -->option is used to display a prompt before reading the input.

    fi
    done 

}



DB_Connection() {

if [ -e "Databases/$DBname" ]; then

                cd  Databases/$DBname 
                pwd 
                echo "Connected to DB successfully"

                . ../../Table-Scripts/Table-Menu.sh
                
            fi          
        

}
