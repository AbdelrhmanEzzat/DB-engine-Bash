#!/usr/bin/bash
. ../../Methods/Table-methods.sh

 metadata="$tableName-metadata"
 
#searches for the field "pk" in the metadata file and prints the value of the next field. 


insertspecefic(){

        PK_exist

declare -i i=1
#echo  "" >> ./Databases/$mydb/$tableName

declare Ncol=$(sed -n '3p' "../../Databases/$mydb/$tableName-metadata" ) # N of col entered by user when table creation 

while (true)
do
    if [[ $i != $Ncol ]]; then
        #skip the first col = PK 

    s=$(sed -n '1p' ../../Databases/$mydb/$tableName | awk -F: -v i=$((i+1)) '{print $i}')
    echo -n "please enter $s = "
    read -p "" input
    input_validation #validate the input 
    
    echo -n $input":" >> ../../Databases/$mydb/$tableName
    i=$i+1
    else
        break
    fi

done
}


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