. ../../Color.sh
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
pkname(){ #Name of primary key column
    read -p "Enter Name of primary key column ? preferred word : " pk
    pk_validation   #Validate the input "PK"
    if [ $pk ];then 
       
        echo "pk:$pk" >> ../$mydb/$tableName-metadata
        Datatype
        echo -n $pk":" >> ../$mydb/$tableName
    else
        pkname
    fi
}

PK_exist(){ #Check for PK exist or not -- Dublicate ? -- Not null !! ---
    read -p "Your new PK: " primary

    primary_validation


pksValues=$(cut -d ":" -f 1 ../$mydb/$tableName) #extracts the primary key values

    if echo "$pksValues" | grep -wq "$primary"; then #used to search for an exact match 

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

get_row(){ #take pk and get the col by pk 
    #declare line 

       

           read -p "Your  PK to get the record : " S_id
           primary_select # need check 

pksValues=$(cut -d ":" -f 1 ../$mydb/$tableName) #extracts the primary key values

    if echo "$pksValues" | grep -wq "$S_id"; then #used to search for an exact match 

    echo -e "${BLUE}ID Exist${NC}"
    else
    echo -e "${RED}ID Not Exist${NC}"
    get_row
    fi
           

    fieldNumber='1'
    pksValues=`sed '1d' "../../Databases/$mydb/$tableName" |cut -d ":" -f $fieldNumber `
    re='^[0-9]+$'
    for value in $pksValues
    do
# Search for the line with the matching ID in the file

        if [[ "$S_id" == "$value" ]]; then 
            line=$(grep "^$S_id[^0-9]" "../../Databases/$mydb/$tableName")
            # Check if a matching line was found
                if [[ -n "$line" ]]; then # -n >> if a string is not empty
                echo  $line
                # if line or table empty return table is empty

                break

                else
                echo -e "${RED}No matching line found for ID: $S_id${NC}"
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

if [[ ${tableName:0:1} =~ [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your table Name : " tableName

elif [[ -z $tableName ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName =~ *['!'[]{}=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your table Name : " tableName


elif [[ $tableName =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $mydb =~ *[\']* ]];then
echo -e "${RED}invalid don't use single qoute ${NC}"
read -p "Enter Your DataBase : " tableName

elif [[ $tableName =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your table Name : " tableName

elif [[ $tableName =~ *[" "]* ]];then
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

if [[ ${mydb:0:1} =~ [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ -z $mydb ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " mydb


elif [[ $mydb =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb =~ *[\']* ]];then
echo -e "${RED}invalid don't use single qoute ${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb =~ [\/] ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb =~ *[" "]* ]];then
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




if [[ -z $new_value ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your New Value : " new_value

elif [[ $new_value =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]*  && ! $new_value =~ ^[0-9]+$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your New Value again : " new_value

elif [[ $new_value =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your New Value again : " new_value

elif [[ ${#new_value} -gt 20 ]];then
echo -e "${RED}invalid more than 20 ch${NC}"
read -p "Enter Your New Value again : " new_value

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
read -p "Enter Your input again : " input

elif [[ $input =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* && ! $input =~ ^[0-9]+$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your input again : " input

# elif [[ $input =~ ^[a-zA-Z]*$ ]];then
# echo -e "${RED}invalid${NC}"
# read -p "Enter Your input again : " input

elif [[ $input =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your input again : " input

elif [[ $input =~ *[\']* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your input again : " input

elif [[ $tableName =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your input again : " input

elif [[ $tableName =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your input again : " input

elif [[ $tableName =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your input again : " input

elif [[ ${#input} -gt 15 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your input again : " input

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


if [[ ${pk:0:1} =~ [0-9] ]];then 
echo -e "${RED}Dont Enter Zero or number ${NC}"
read -p "Enter Your pk : " pk

elif [[ -z $pk ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your pk again : " pk

elif [[ $pk =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your pk again : " pk

elif [[ $pk =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your pk again : " pk

elif [[ $pk =~ *[\']* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your pk again : " pk


elif [[ $pk =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your pk again : " pk

elif [[ $pk =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your pk again : " pk

elif [[ $pk =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your input again : " pk

elif [[ ${#pk} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your pk : " pk

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}

primary_validation(){ #PK Validation on added onto table 

while true
do
# first one need path -- and others for naming 


if [[ $primary =~ ^[a-zA-Z]*$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " primary

elif [[ ${primary:0:1} =~ [0] ]];then 
echo -e "${RED}Dont Enter Zero${NC}"
read -p "Enter Your  primary again : " primary

elif [[ -z $primary ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your primary again : " primary


elif [[ $primary =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* && ! $primary =~ ^[1-9]+$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " primary

elif [[ $primary =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " primary

elif [[ $primary =~ *[\']* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " primary

elif [[ $primary =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your primary again : " primary

elif [[ $primary =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your primary again : " primary

elif [[ $primary =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your primary again : " primary


elif [[ ${#primary} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your primary  again: " primary

else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}

primary_select(){ #PK select

while true
do
# first one need path -- and others for naming 


if [[ $S_id =~ ^[a-zA-Z]*$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " S_id

elif [[ ${S_id:0:1} =~ [0] ]];then 
echo -e "${RED}Dont Enter Zero${NC}"
read -p "Enter Your  primary again : " S_id

elif [[ -z $S_id ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your primary again : " S_id

elif [[ $S_id =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* && ! $S_id =~ ^[1-9]+$ ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " S_id

elif [[ $S_id =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " S_id

elif [[ $S_id =~ *[\']* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your primary again : " S_id

elif [[ $S_id =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your primary again : " S_id

elif [[ $S_id =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your primary again : " S_id

elif [[ $S_id =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your primary again : " S_id


elif [[ ${#S_id} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your primary  again: " S_id

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


if [[ ${columnName:0:1} =~ [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ -z $columnName ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ $columnName =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ $columnName =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ $columnName =~ *[\']* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ $columnName =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ $columnName =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ $columnName =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your column Name again : " columnName

elif [[ ${#columnName} -gt 8 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your column Name again : " columnName


else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}





############################# NUM OF COLs  ###############
columnsNum(){

while true
do
# first one need path -- and others for naming
if [[ ${columnsNum:0:1} =~ [0] ]];then 
echo -e "${RED}Dont Enter Zero${NC}"
read -p "Enter Your column Num : " columnsNum


elif [[ -z $columnsNum ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your column Num : " columnsNum

elif [[ $columnsNum =~ *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* && ! $columnsNum =~ ^[1-9]+$ ]];then
echo -e "${RED}invalid SC${NC}"
read -p "Enter Your column Num : " columnsNum

elif [[ $columnsNum =~ *[" "]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your column Num : " columnsNum

elif [[ $columnsNum =~ *[\']* ]];then
echo -e "${RED}invalid single qoute ${NC}"
read -p "Enter Your column Num : " columnsNum


elif [[ $columnsNum =~ *[\.]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your column Num again : " columnsNum

elif [[ $columnsNum =~ *[\..]* ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your column Num again : " columnsNum

elif [[ $columnsNum =~ *[\/]* ]];then
echo -e "${RED}invalid don't use Slash ${NC}"
read -p "Enter Your column Num again : " columnsNum

elif [[ $columnsNum =~ ^[a-zA-Z]*$ ]];then
echo -e "${RED}invalid char${NC}"
read -p "Enter Your column Num : " columnsNum


elif [[ ${#columnsNum} -gt 2 ]];then
echo -e "${RED}invalid more than 8 ch${NC}"
read -p "Enter Your column Num : " columnsNum



else
    echo -e "${BLUE}Valids${NC}"
break


fi
done
}


col_exist_createT(){
    
while true 
do

pksValues=$(sed -n '1s/:/ /gp' ../../Databases/$mydb/$tableName)

    if echo "$pksValues" | grep -wq "$columnName"; then

             echo "Duplicated value"
             break


        elif [ -z "$columnName" ]; then

    echo "Can't be empty"
    break

else
 echo -n -e "Column Name Not exist"
 break
    
fi
done
}

