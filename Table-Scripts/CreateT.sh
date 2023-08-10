#!/usr/bin/bash 

export LC_COLLATE=C
shopt -s extglob


    #Call tables methods 
    . ../../Methods/Table-methods.sh

#Input







    DB_validation 
    Table_validation
       
        touch ../../Databases/$mydb/$tableName
        touch ../../Databases/$mydb/$tableName-metadata







 while true
    do

    read -p "Enter number of coloumns : " columnsNum
    if [[ $columnsNum ]] && [[ "$columnsNum" =~ ^[0-9]+$ ]];then

        break
    fi
    done

    ###
    pkname

    declare -i i=2
    while (( i < $columnsNum+1 ))
    do
        read -p "Enter column $i name : " columnName; 
        ###
        Datatype

        echo -n $columnName":" >> ../$mydb/$tableName 
        i=($i+1)

    done

    #add num of col in the last of metadata file 
    echo -e "\n $columnsNum" >> ../$mydb/$tableName-metadata 


echo " "
 . ../../Table-Scripts/Table-Menu.sh

