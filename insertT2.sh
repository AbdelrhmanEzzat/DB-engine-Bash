

PK_exist(){
    read -p "Your new PK: " primary


pksValues=$(cut -d ":" -f 1 Databases/$mydb/$tableName)

    if echo "$pksValues" | grep -wq "$primary"; then

    echo "Duplicated value, must be unique"
            PK_exist

elif [ -z "$primary" ]; then

    echo "NOT NULL value"
    PK_exist

else
 echo -n -e "\n $primary:" >> Databases/$mydb/$tableName
    
   # echo -e "\n$primary:" >> Databases/$mydb/$tableName
fi
 

}

