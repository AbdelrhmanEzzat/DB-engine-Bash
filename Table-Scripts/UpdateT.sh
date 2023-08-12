#!/bin/bash

read -p "Enter Database name " mydb
read -p "Enter table name you want to updated " tableName



insertspecefic(){

declare -i i=1
#echo  "" >> ./Databases/$mydb/$tableName


# Get specific row by enter the PK  
. TUpdate.sh
# Get specific row by enter the PK  



#get No. col from metadata file 
Ncol=$(sed -n '3p' Databases/$mydb/$tableName-metadata ) # N of col entered by user when table creation 
#get No. col from metadata file 


# this loop iterate for each value in row to append the new value 
# note ::: if user want to let the old value at it is >>> " let field empty and press enter "

while (true)
do  

    if ((  $i != $Ncol ));then

    #skip the first col = PK 
    # we get the line from get_row function and pass it to AWK to split line for updating 

    old_value=$(echo "$line" | awk -F: -v i=$(($i+1)) '{print $i}') # store table header into S
    echo -n "the current value is : $old_value "
    read -p "Enter the new value : " new_value

    sed -i "s/$old_value/$new_value/g" "Databases/$mydb/$tableName"

    echo "Value '$old_value' replaced with '$new_value' successfully"
    
    #echo -n $input":" >> ./Databases/$mydb/$tableName
    i=$i+1
    else
        cat Databases/$mydb/$tableName
        break
    fi

done
}
insertspecefic

update_row() {
# change value from old to new 


if [ -f "Databases/$mydb/$tableName" ]; then

sed -i "s/$old_value/$new_value/g" "Databases/$mydb/$tableName" 

echo "Value '$old_value' replaced with '$new_value' successfully"

else 

echo "File not found!"

update_row

fi 
}
