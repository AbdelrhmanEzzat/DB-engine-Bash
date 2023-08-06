#!/usr/bin/bash 

export LC_COLLATE=C
shopt -s extglob


    #Call tables methods 
. ../Methods/Table-methods.sh

#Input
read -p "what is database name " DBname

DB_Check




#Input
read -p "Enter table name you want to create : " tableName
namingRegex




#need loop
while (true) 
do
    if [ -f ../Databases/$DBname/$tableName ] ;then
        echo "Table with name $tableName already exists" 
        echo -e "\n Please Enter A Vaild Name (only letters preferred) " 
        read -p "Enter table name you want to create : " tableName
    else 
        touch ../Databases/$DBname/$tableName
        touch ../Databases/$DBname/$tableName-metadata
        break
    fi
done






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

        echo -n $columnName":" >> ../Databases/$DBname/$tableName 
        i=($i+1)

    done


echo " "
 . Table-Menu.sh

