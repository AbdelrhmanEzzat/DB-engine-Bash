
# Database Name checking FUN
DB_Check() {
   while (true)
   do

            if [ -e ../Databases/$DBname ]; then 
                echo " Database Successfully exist ^_^ "
                break
               
            else

                 echo "Database already exists"
                echo -e "\n Please Enter A Vaild Name (only letters preferred) "  # -e -->enables the interpretation of backslash escapes
                read -p "Enter DataBase name you want to create : " DBname # -p -->option is used to display a prompt before reading the input.

                
              
       
    fi
    done 

}

Table_Check() {
   while (true)
   do

            if [ -f ../Databases/$DBname/$tableName ]; then 
                echo "Successfully exist ^_^ "
                break
               
            else

                 echo "Database File already exists"
                echo -e "\n Please Enter A Vaild Name (only letters preferred) "  # -e -->enables the interpretation of backslash escapes
                read -p "Enter DataBase name you want to create : " tableName # -p -->option is used to display a prompt before reading the input.

                
              
       
    fi
    done 

}


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
 echo -n -e "\n$primary:" >> Databases/$mydb/$tableName
    
   # echo -e "\n$primary:" >> Databases/$mydb/$tableName
fi
 

}

get_row(){
    declare line 

        # read -p "Your new DB: " mydb

        #  read -p "Your new TN: " tableName

         read -p "Your  PK to get the record : " S_id

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
                # if line or table empty return table is empty

                break

                else
                echo "No matching line found for ID: $S_id"
                get_row
                fi

        fi
    done
}

