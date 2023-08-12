#!/usr/bin/bash
. ../../Methods/Table-methods.sh

 metadata="$tableName-metadata"
 declare -i NF=0
    pk_meta=$(awk 'BEGIN{FS=":"}
    {
    i=1
    while(i<=NF){ 
    if ($i=="pk"){
    print $((i+1))}
    i++
    }
    }
    ' ./Databases/$mydb/$metadata)
#searches for the field "pk" in the metadata file and prints the value of the next field. 


insertspecefic(){

        PK_exist

declare -i i=1
#echo  "" >> ./Databases/$mydb/$tableName
pwd
declare Ncol=$(sed -n '3p' /../../Databases/$mydb/$tableName-metadata ) # N of col entered by user when table creation 
pwd
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

# insertRow(){
#     echo "please enter you data in order as follows and make sure that primary key is a unique value your primary key is $pk"
#     s=$(sed -n /name/p Databases/$mydb/$tableName)
#     echo "insert into $s"
#     read -p " " newRow
#     echo  "" >> ./Databases/$mydb/$tableName
#     echo -n $newRow":" >> ./Databases/$mydb/$tableName
#     }

# selectoption(){

#         echo " choose the way of insert you wanna use"
#     options=("insert by row" "insert one by one")
#     select opt in "${options[@]}"
#     do
#     case $opt in
#         "insert by row")
#             echo "NOTE : BE CAREFUL INSERT ROW MUST BE IN SAME ORDER AS FOLLOWS OR YOU LOSE DATA CONSISTNSY"          
#             insertRow
#             echo " "
#             bash ./TableMainMenu.sh
#             ;;
#         "insert one by one")
#             insertspecefic
#             echo " 1) Create Table       3) Drop Table         5) Select from Table  7) Update Table
#                    2) List Table         4) Insert into Table  6) Delete from Table  8) Exit"
#             bash ./TableMainMenu.sh
#             ;;
#         *) echo "invalid option $REPLY please try again" 
#            echo "choose the way of insert you wanna use"
#            echo "insert by row "
#            echo "insert one by one" ;;
#     esac
#     done

#     }


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