#!/bin/bash

#read -p "Enter Database name " mydb
#sread -p "Enter table name you want to updated " tableName
while true
do
read -p "Enter Database name " mydb
DB_validation

if  [[ -d ../../Databases/$mydb ]];then
echo -e "${BLUE}Already Exist${NC}"
break

else
echo -e "${BLUE}DB NOT Exist${NC}"
fi
done

while true 
do
##Table
read -p "Enter table name you want to select " tableName
Table_validation
 if [[  -f ../../Databases/$mydb/$tableName ]]; then
        echo -e "${BLUE}Table  Exist${NC}"

            insertspecefic

        break
else 
        echo -e "${RED}Table  NOT Exist${NC}"

fi
done






bash ../../Table-Scripts/Table-Menu.sh



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

    echo -e "${BLUE}Value '$old_value' replaced with '$new_value' successfully${NC}"
    
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

echo -e"${BLUE} Value '$old_value' replaced with '$new_value' successfully${NC} "

else 

echo -e "${RED}File not found!${NC}"

update_row

fi 
}

