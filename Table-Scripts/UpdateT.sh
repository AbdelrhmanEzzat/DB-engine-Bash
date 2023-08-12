#!/bin/bash

. ../../Methods/Table-methods.sh




update_specefic(){
declare line=$(grep "^$S_id[^0-9]" "../../Databases/$mydb/$tableName")
declare -i i=1
#echo  "" >> ./Databases/$mydb/$tableName


# Get specific row by enter the PK  

# Get specific row by enter the PK  



#get No. col from metadata file 
Ncol=$(sed -n '3p' ../../Databases/$mydb/$tableName-metadata ) # N of col entered by user when table creation 
#get No. col from metadata file 





PK_exist_update # this function tottaly ckeck the PK and update to new one

# this loop iterate for each value in row to append the new value 
# note ::: if user want to let the old value at it is >>> " let field empty and press enter "
while (true)
do  

    if [[  $i != $Ncol ]];then

    #skip the first col = PK 
    # we get the line from get_row function and pass it to AWK to split line for updating 
    old_value=$(echo "$line" | awk -F: -v i=$(($i+1)) '{print $i}') # store table header into S
    echo -n "the current value is : $old_value "
    read -p "Enter the new value : " new_value
    new_value_validation

    sed -i "s/"$old_value"/"$new_value"/g" "../../Databases/$mydb/$tableName"

    echo -e "${BLUE}Value '$old_value' replaced with '$new_value' successfully${NC}"
    
    #echo -n $input":" >> ./Databases/$mydb/$tableName
    i=$i+1
    else
        cat ../../Databases/$mydb/$tableName
        echo -e "\n"
        break
    fi

done
}



PK_exist_update(){
declare line=$(grep "^$S_id[^0-9]" "../../Databases/$mydb/$tableName")



    old_primary=$(echo "$line" | cut -d: -f1 ) # get the first col in line 
while true
do
    read -p "Your new PK: " primary
    primary_validation


pksValues=$(cut -d ":" -f 1 ../../Databases/$mydb/$tableName) #extracts the primary key values

    if echo "$pksValues" | grep -wq "$primary"; then #used to search for an exact match 

    echo "Duplicated value, must be unique"

elif [ -z "$primary" ]; then

    echo "NOT NULL value"
    

else
    echo $old_value
    sed -i "s/$(echo "$old_primary")/"$primary"/g" "../../Databases/$mydb/$tableName"

    echo -e "${BLUE}Value '$old_primary' replaced with '$primary' successfully${NC}"
    break
   # echo -e "\n$primary:" >> Databases/$mydb/$tableName
fi
 done
}


while true
do
    read -p "Enter Database name :" mydb
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
read -p "Enter table name you want to select :" tableName
Table_validation
 if [[  -f ../../Databases/$mydb/$tableName ]]; then
        echo -e "${BLUE}Table  Exist${NC}"

            get_row
            update_specefic

        break
else 
        echo -e "${RED}Table  NOT Exist${NC}"

fi
done
