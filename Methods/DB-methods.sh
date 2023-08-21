#!/usr/bin/bash
. Color.sh
#Function to check for the input syntax and file is exist or not ;

createDB_Name() {

   read -p "Enter DB name :" mydb  #display a prompt message to the user before reading input
    DB_validation

    

            if [[ -e "Databases/$mydb" ]]; then 

                echo -e "${RED}Database already exist${NC}"
                createDB_Name

           else
                mkdir "Databases/$mydb"
                echo -e "${BLUE} Database Successfully created ^_^ ${NC}"
                . DB-Scripts/ConnectDB.sh

                
           fi
            
     

}



DB_Connection() {


while true 
    do 
    ##DB
    read -p "what is database name " mydb
    DB_validation
            if  [[ -d Databases/$mydb ]];then
                            echo -e "${BLUE}Already Exist${NC}"
                            cd  Databases/$mydb 
                                            pwd 
                                            echo -e "${BLUE}Connected to DB successfully${NC}"

                                            . ../../Table-Scripts/Table-Menu.sh
                            break
                else 
                echo -e "${RED}DB NOT Exist${NC}"
            fi 
    done
         

              

}

DropDB() {
read -p "Enter the DataBase you want To Remove : " mydb
DB_validation


        if [[ -e "Databases/$mydb" ]]; then

        rm -r "Databases/$mydb"
        echo -e "${BLUE}Removed Successfully${NC}"
            
        else 
             echo -e "${RED}No DataBase${NC}"
                DropDB
        fi
}



DB_validation(){

while true
do

if  [[ -d $mydb ]];then
echo -e "${RED}Already Exist${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ ${mydb:0:1} == [0-9] ]];then 
echo -e "${RED}Dont Enter the Number${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ -z $mydb ]];then
echo -e "${RED}cant enter an empty name${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb == *['!'=?@#\$%^\&*()_+-\;\"\`\>\<\/\|\~]* ]];then
echo -e "${RED}invalid${NC}"
read -p "Enter Your DataBase : " mydb


elif [[ $mydb == *[\.]* || $mydb == [\.] ]];then
echo -e "${RED}invalid don't use DOT${NC}"
read -p "Enter Your DataBase : " mydb

elif [[ $mydb == *[\']* ]];then
echo -e "${RED}invalid don't use single qoute ${NC}"
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