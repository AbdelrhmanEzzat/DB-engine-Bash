read -p "what is Database name " DBname
read -p "Enter table name you want to list : " TableName


#DB check 
if [ -f ../Databases/$DBname/$tableName ] ;then
    cat ../Databases/$DBname/$tableName

else 
       echo "Table with name $tableName Not exists try again or exit"
       options=("For try again choose >> 1" "For exit choose >> 2")
        select op in "${options[@]}"
            do
            case $op in

            "For try again choose >> 1")

            echo "try again"
            read -p "Enter table name you want to list : " TableName
            if [ -f Databases/$DBname/$tableName ] ; then
                cat Databases/$DBname/$tableName
                break
            else 
                echo "Table with name $tableName Not exists please try again or exit"
                echo "For try again choose >> 1" "For exit choose >> 2"
            fi

            ;;

            "For exit choose >> 2")
            echo "exit"
            
            break
            ;;
            
        *) 
        echo "invalid option $REPLY please try again";;
    esac
    done 

fi
echo " "
bash ./TableMainMenu.sh