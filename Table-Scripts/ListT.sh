. ../../Methods/Table-methods.sh

read -p "what is Database name " mydb #DB
DB_validation


if  [[ -d ../../Databases/$mydb ]];then
echo -e "${BLUE}Already Exist${NC}"


read -p "Enter table name you want to list : " tableName #TableName validation 
Table_validation
if  [[ -f ../../Databases/$mydb/$tableName ]];then
        echo -e "${BLUE}Already Exist${NC}"
        echo -e "${YELLOW}========================================${NC}"
            cat ../../Databases/$mydb/$tableName
        echo -e "\n${YELLOW}========================================${NC}"
        else 
        echo -e "${RED}Table Not Exist${NC}"
        fi
else 

echo -e "${RED}DB Not Exist${NC}"
fi
echo " "
bash ../../Table-Scripts/Table-Menu.sh