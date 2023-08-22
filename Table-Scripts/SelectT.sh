#!/usr/bin/bash
. ../../Methods/Table-methods.sh


while true 
do 
##DB
read -p "what is database name " mydb
DB_validation
if  [[ -d ../../Databases/$mydb ]];then
echo -e "${BLUE}Already Exist${NC}"
break
else 
echo -e "${RED}DB NOT Exist${NC}"
fi 
done


while true 
do
##Table
read -p "Enter table name you want to select " tableName
Table_validation
 if [[  -f ../../Databases/$mydb/$tableName ]]; then
        echo -e "${BLUE}Table  Exist${NC}"
        break
else 
        echo -e "${RED}Table  NOT Exist${NC}"

fi
done



#must make cd after every function execute
selectcolumn(){
   read -p "Please enter the column you want to select: " columnName
   columnName

fieldNumber=$(awk -F ':' -v columnName="$columnName" 'NR == 1 { for (i=1; i<=NF; i++) if ($i == columnName) { print i; break } }' ../../Databases/$mydb/$tableName)

if [[ -n $fieldNumber ]]; then # if number
    sed '1d' ../../Databases/$mydb/$tableName | cut -d ':' -f $fieldNumber
else
    echo "Column not found."
fi
     

}




    PS3='Enter your choice: '
    options=("Select All" "Select By Col" "Select By Row" "Main Menu")

    select op in "${options[@]}"
    do
    case $op in
        "Select All")
            echo "Select all from $tableName"  
             echo -e "${YELLOW}========================================${NC}"        
            cat ../../Databases/$mydb/$tableName
             echo -e "\n${YELLOW}========================================${NC}"
            ;;
        "Select By Col")
        
            selectcolumn
      
            ;;
            "Select By Row")
            get_row
      
            ;;

            "Main Menu") 

            . ../../Table-Scripts/Table-Menu.sh
          
           ;;
        *) 
           echo "invalid option $REPLY try again" 
          
           ;;
    esac
    done


