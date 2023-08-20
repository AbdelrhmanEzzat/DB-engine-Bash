#!/usr/bin/bash 

export LC_COLLATE=C
shopt -s extglob


    #Call tables methods 
    #pwd
    . ../../Methods/Table-methods.sh

#Input
#Validation



while true
do

read -p "Enter Your DataBase : " mydb
    DB_validation #Validation

if  [[ -d ../../Databases/$mydb ]];then
echo -e "${RED}Already Exist${NC}"

read -p "Enter Table name you want to create : " tableName
    Table_validation #Validation

    if [[  -f ../../Databases/$mydb/$tableName ]]; then
        echo -e "${RED}Table  Exist${NC}"
        
        else 
        echo -e "${BLUE}Table  NOT Exist${NC}"
         touch ../../Databases/$mydb/$tableName
        touch ../../Databases/$mydb/$tableName-metadata
        break

fi


else #true

echo -e "${RED}DB Not Exist${NC}"

fi
done

    









 while true
    do

    read -p "Enter number of coloumns : " columnsNum
    if [[ $columnsNum ]];then
            columnsNum #Validation


        break
    fi
    done

    ###
    pkname #write PK datatype in metadata

    declare -i i=2

    while (( i < $columnsNum+1 ))
    do
        

            while true
            do
            read -p "Enter column $i name : " columnName;

                columnName #Validation

                #validate col duplicated 
            pksValues=$(sed -n '1s/:/ /gp' ../../Databases/$mydb/$tableName)
                colvalues=$(echo "$pksValues" | grep -wq "$columnName")
                if echo "$pksValues" | grep -wq "$columnName"; then

                        echo -e "${RED}Duplicated value${NC}"
                        
                        


                elif [ -z "$columnName" ]; then

                echo -e "${RED}Can't be empty${NC}"
                

            else
            echo  -e "${BLUE}Column Name Not exist${NC}"
            break
    
fi
done







        ### select datatype for each inputs
        Datatype

        echo -n $columnName":" >> ../$mydb/$tableName 
        i=($i+1)

    done

    #add num of col in the last of metadata file 
    echo -e "\n$columnsNum" >> ../$mydb/$tableName-metadata 


echo " "
 . ../../Table-Scripts/Table-Menu.sh

