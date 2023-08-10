#!/bin/bash
echo "Delete from Table "
read -p "Enter a Table you want to Delete: " tableName

PS3='Please enter your choice: '
options=("Delete Record" "Delete all"  "Exit")

while (true) 
do
        ##
        if [[ ! -f ../Databases/$DBname/$tableName || -z ../Databases/$DBname/$tableName  ]]; then
            echo "invalid"
            read -p "Enter a Table you want to Delete: " tableName #validate 
            
        else

               select op in "${options[@]}"
               do
                  case $op in
                    "Delete Record")

                    read -p "Enter number of Row you want to delete " y # validate 
                    # loop to ignore zero input
                    #start after the table header

                    y=$(($y + 1))
                    x=$(sed -n /$y/p ../Databases/$DBname/$tableName)

                    #
                    if [[ $y ]] && [[ $x ]]; then
                    echo "Delete $y from $tableName"
                    sed -i $y'd' ../Databases/$DBname/$tableName
                        else
                             echo "column invalid"
                    fi

                    ;;
                    "Delete all")
                     sed -i '1,$d' ../Databases/$DBname/$tableName
                     sed -i '1,$d' ../Databases/$DBname/$tableName-metadata

                    ;;
                    "Exit")
                        break

                    ;;

                    *)
                     echo "invalid option $REPLY"
                     ;;
                esac
                done 
    fi
    
done                         