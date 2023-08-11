
# Database Name checking FUN
# DB_Check() {
#    while (true)
#    do

#             if [ -e ../Databases/$DBname ]; then 
#                 echo " Database Successfully exist ^_^ "
#                 break
               
#             else

#                  echo "Database already exists"
#                 echo -e "\n Please Enter A Vaild Name (only letters preferred) "  # -e -->enables the interpretation of backslash escapes
#                 read -p "Enter DataBase name you want to create : " DBname # -p -->option is used to display a prompt before reading the input.

                
              
       
#     fi
#     done 

# }

# Table_Check() {
#    while (true)
#    do

#             if [ -f ../Databases/$DBname/$tableName ]; then 
#                 echo "Successfully exist ^_^ "
#                 break
               
#             else

#                  echo "Database File already exists"
#                 echo -e "\n Please Enter A Vaild Name (only letters preferred) "  # -e -->enables the interpretation of backslash escapes
#                 read -p "Enter DataBase name you want to create : " tableName # -p -->option is used to display a prompt before reading the input.

                
              
       
#     fi
#     done 

# }



Datatype() {
        echo " what is the data type of the Column ?"
        options=("For int choose >> 1" "For string choose >> 2")

    select op in "${options[@]}"
    do
    case $op in
        "For int choose >> 1")
            echo "int"
            datatype="int"           
            echo -n $datatype":" >> ../$mydb/$tableName-metadata
            break;
            ;;

        "For string choose >> 2")
            echo "string"
            datatype="string"
            echo -n $datatype":" >> ../$mydb/$tableName-metadata
            break;
            ;;

        *) echo "invalid option $REPLY please try again";;
    esac
    done

}
pkname(){
    read -p "enter name of primary key column ?" pk
    if [ $pk ];then 
        pk_validation #Validate the input "PK"
        echo "pk:$pk" >> ../$mydb/$tableName-metadata
        Datatype
        echo -n $pk":" >> ../$mydb/$tableName
    else
        pkname
    fi
}

PK_exist(){
    read -p "Your new PK: " primary

    primary_validation


pksValues=$(cut -d ":" -f 1 ../$mydb/$tableName)

    if echo "$pksValues" | grep -wq "$primary"; then

    echo "Duplicated value, must be unique"
            PK_exist

elif [ -z "$primary" ]; then

    echo "NOT NULL value"
    PK_exist

else
 echo -n -e "\n$primary:" >> ../$mydb/$tableName
    
   # echo -e "\n$primary:" >> Databases/$mydb/$tableName
fi
 

}

get_row(){
    declare line 

        # read -p "Your new DB: " mydb

        #  read -p "Your new TN: " tableName

         read -p "Your  PK to get the record : " S_id

    fieldNumber=`awk -v RS=':' "/id/"'{print NR}' ../Databases/$mydb/$tableName`
    pksValues=`sed '1d' ../Databases/$mydb/$tableName |cut -d ":" -f $fieldNumber `
    re='^[0-9]+$'
    for value in $pksValues
    do
# Search for the line with the matching ID in the file

        if [[ "$S_id" == "$value" ]]; then 
            line=$(grep "^$S_id[^0-9]" ../Databases/$mydb/$tableName)
            # Check if a matching line was found
                if [[ -n "$line" ]]; then
                echo  $line
                # if line or table empty return table is empty

                break

                else
                echo "No matching line found for ID: $S_id"
                get_row
                fi

        fi
    done
}


Table_validation(){

while true
do
# first one need path -- and others for naming 

# if  [[ -f ../Databases/$mydb/$tableName ]];then
# echo -e "${RED}Already Exist${NC}"
# read -p "Enter Your table Name : " tableName

if [[ ${tableName:0:1} == [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your table Name : " tableName

elif [[ -z $tableName ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName == *['!'@#\$%^\&*()_+\>\<]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your table Name : " tableName


elif [[ $tableName == *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName == *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName == *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your table Name : " tableName

elif [[ ${#tableName} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your table Name : " tableName

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}


DB_validation(){

while true
do

# if  [[ -d $mydb ]];then
# echo -e "${RED}Already Exist${NC}"
# read -p "Enter Your DataBase : " mydb

if [[ ${mydb:0:1} == [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ -z $mydb ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb == *['!'@#\$%^\&*()_+\>\<\/]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " mydb


elif [[ $mydb == *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb == [\/] ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ ${#mydb} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your DataBase : " mydb

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}

new_value_validation(){ #Updating value

while true
do
# first one need path -- and others for naming 


if [[ ${new_value:0:1} == [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your DataBase : " new_value

elif [[ -z $new_value ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your DataBase : " new_value

elif [[ $new_value == *['!'@#\$%^\&*()_+]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " new_value

elif [[ $new_value == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " new_value

elif [[ $new_value == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " new_value

elif [[ ${#new_value} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your DataBase : " new_value

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}


input_validation(){ # input when inserting 

while true
do
# first one need path -- and others for naming 



if [[ -z $input ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your DataBase : " input

elif [[ $input == *['!'@#\$%^\&*()_+]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " input

elif [[ $input == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " input

elif [[ $input == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " input

elif [[ ${#input} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your DataBase : " input

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}



pk_validation(){ #PKname

while true
do
# first one need path -- and others for naming 


if [[ ${pk:0:1} == [0] ]];then 
echo -e "${RED}Dont Enter Zero${NC}"
read -p "Enter Your pk : " pk

elif [[ -z $pk ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your pk : " pk

elif [[ $pk == *['!'@#\$%^\&*()_+]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your pk : " pk

elif [[ $pk == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your pk : " pk


elif [[ ${#pk} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your pk : " pk

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}

primary_validation(){ #PK exist

while true
do
# first one need path -- and others for naming 


if [[ $primary == ^[a-zA-Z]*$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary : " primary

elif [[ ${primary:0:1} == [0] ]];then 
echo -e "${RED}Dont Enter Zero${NC}"
read -p "Enter Your  primary : " primary

elif [[ -z $primary ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your primary : " primary

elif [[ $primary == *['!'@#\$%^\&*()_+]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary : " primary

elif [[ $primary == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your pprimaryk : " primary

elif [[ ${#primary} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your primary : " primary

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}

columnName(){

while true
do
# first one need path -- and others for naming 


if [[ ${columnName:0:1} == [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your column Name : " columnName

elif [[ -z $columnName ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your column Name : " columnName

elif [[ $columnName == *['!'@#\$%^\&*()_+]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Name : " columnName

elif [[ $columnName == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Name : " columnName

elif [[ ${#columnName} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your column Name : " columnName


else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}

columnsNum(){

while true
do
# first one need path -- and others for naming
if [[ ${columnsNum:0:1} == [0] ]];then 
echo -e "${RED}Dont Enter Zero${NC}"
read -p "Enter Your column Num : " columnsNum


elif [[ -z $columnsNum ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your column Num : " columnsNum

elif [[ $columnsNum == *['!'@#\$%^\&*()_+]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Num : " columnsNum

elif [[ $columnsNum == *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Num : " columnsNum

elif [[ $columnsNum =~ ^[a-zA-Z]*$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Num : " columnsNum


elif [[ ${#columnsNum} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your column Num : " columnsNum



else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}
