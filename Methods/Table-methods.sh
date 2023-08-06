
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



