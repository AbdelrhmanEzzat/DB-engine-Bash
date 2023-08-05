#!/usr/bin/bash 

export LC_COLLATE=C
shopt -s extglob

read -p "what is database name " DBname
#need to check 

 

namingRegex(){
    while (true)
    do
        if [[ $tableName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then
            break;
        else
            echo -e "\n Please Enter A Vaild Name (only letters preferred) " 
            read -p "Enter table name you want to create : " tableName
        fi
    done
}


Datatype() {
        echo " what is the data type of the Column ?"
        options=("For int choose >> 1" "For string choose >> 2")

    select op in "${options[@]}"
    do
    case $op in
        "For int choose >> 1")
            echo "int"
            datatype="int"           
            echo -n $datatype":" >> ../Databases/$DBname/$tableName-metadata
            break;
            ;;

        "For string choose >> 2")
            echo "string"
            datatype="string"
            echo -n $datatype":" >> ../Databases/$DBname/$tableName-metadata
            break;
            ;;

        *) echo "invalid option $REPLY please try again";;
    esac
    done

}
pkname(){
    read -p "enter name of primary key column ?" pk
    if [ $pk ];then 
        echo "pk:$pk" >> ../Databases/$DBname/$tableName-metadata
        Datatype
        echo -n $pk":" >> ../Databases/$DBname/$tableName
    else
        pkname
    fi
}

read -p "Enter table name you want to create : " tableName
namingRegex


#need loop
if [ -f ../Databases/$DBname/$tableName ] ;then
    echo "Table with name $tableName already exists" 
else 
    touch ../Databases/$DBname/$tableName
    touch ../Databases/$DBname/$tableName-metadata


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
fi

echo " "
 . Table-Menu.sh

