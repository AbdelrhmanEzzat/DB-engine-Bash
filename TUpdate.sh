# sed '1d' user |cut -d ":" -f 1

get_col(){
        read -p "Your new DB: " mydb

         read -p "Your new TN: " tableName

         read -p "Your new PK: " S_id

    fieldNumber=`awk -v RS=':' "/id/"'{print NR}' Databases/$mydb/$tableName`
    pksValues=`sed '1d' Databases/$mydb/$tableName |cut -d ":" -f $fieldNumber `
    re='^[0-9]+$'
    for value in $pksValues
    do
# Search for the line with the matching ID in the file

        if [[ "$S_id" == "$value" ]]; then 
            line=$(grep "^$S_id[^0-9]" Databases/$mydb/$tableName)
            # Check if a matching line was found
                if [[ -n "$line" ]]; then
                echo  $line
                break

                else
                echo "No matching line found for ID: $S_id"
                get_col
                fi

        fi
    done
}

get_col