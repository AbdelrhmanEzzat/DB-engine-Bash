#!/bin/bash
. ../../Color.sh

echo "Delete from Table "



while (true) 
do
        ##
    read -p "Enter a Table you want to Delete: " tableName
        Table_validation
        if [[  -f ../../Databases/$mydb/$tableName ]]; then
        echo " - Table  Exist"
        break
            
        else
                    echo "${RED}invalid - Table NOT Exist${NC}"
        fi
done

PS3='Please enter your choice: '
options=("Delete Record" "Delete all")

               select op in "${options[@]}"
               do
                  case $op in
                    "Delete Record")

                    read -p "Enter number of Row you want to delete " y # validate 
                    # loop to ignore zero input
                    #start after the table header

                    y=$(($y + 1))
                    x=$(sed -n /$y/p ../../Databases/$mydb/$tableName)

                    #
                    if [[ $y ]] && [[ $x ]]; then
                    echo "Delete $y from $tableName"
                    sed -i $y'd' ../../Databases/$mydb/$tableName
                        else
                             echo -e "${RED}column invalid${NC}"
                    fi

                    ;;

                    "Delete all")
                     sed -i '2,$d' ../../Databases/$mydb/$tableName
                     #sed -i '1,$d' ../../Databases/$mydb/$tableName-metadata
                        echo -e "${RED}All Table Deleted ${NC}"
                    ;;

                    *)
                     echo "invalid option $REPLY"
                     ;;
                esac
        done 
                        