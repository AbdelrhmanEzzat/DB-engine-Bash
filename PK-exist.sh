

col_exist_createT(){
    read -p "Your new PK: " primary
    

pksValues=$(sed -n '1s/:/ /gp' ../../Databases/$mydb/$tableName)

    if echo "$pksValues" | grep -wq "$primary"; then

    echo "Duplicated value, must be unique"
            col_exist_createT

elif [ -z "$primary" ]; then

    echo "NOT NULL value"
    col_exist_createT

else
 echo -n -e "Column Name Not exist"
    
fi

}

