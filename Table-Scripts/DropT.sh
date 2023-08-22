#!/usr/bin/bash
. ../../Methods/Table-methods.sh

echo -e "${CYAN}Drop Table${NC}"
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


# DB validation 

PS3='Enter your choice: '

options=("List Tables" "Drop Table" "Table Main Menu")
select op in "${options[@]}"
do
    case $op in
        "List Tables")
            ls    

            ;;
        "Drop Table")
            read -p "Enter Table Name : " tableName #DB validation 
            Table_validation
            if [ -f ../../Databases/$mydb/$tableName ]; then
                    rm ../../Databases/$mydb/$tableName
                    rm  ../../Databases/$mydb/$tableName-metadata

		    echo -e "${RED}Table Dropped Successfully${NC}"

            else
                    echo -e "${RED}Table Not Found${NC}"
            fi

            ;;
        "Table Main Menu")

              . ../../Table-Scripts/Table-Menu.sh

            ;;
       
        *) 
        echo -e "${YELLOW}not available option $REPLY${NC}"
        ;;
    esac
done