#!/usr/bin/bash
#insert 1:haidy:1000$:devops:vois   into   id:name:salary:job:company
read -p "what is database name " mydb
read -p "enter table name you want insert into " tableName
 metadata="$tableName-metadata"
 declare -i NF=0
    pk=$(awk 'BEGIN{FS=":"}
    {
    i=1
    while(i<=NF){ 
    if ($i=="pk"){
    print $((i+1))}
    i++
    }
    }
    ' Databases/$mydb/$metadata)


PK_exist(){


    # if awk -F: -v primaryKey="$primaryKey" \
    #     '{ if ($1==primaryKey) exit 1 }' "Databases/$mydb/$tableName"; then
    #     echo "Primary key '$primaryKey' does not exist in table '$tableName'."
    # else
    #     echo "Primary key '$primaryKey' exists in table '$tableName'."
    # fi

 if awk -F: -v primaryKey="$primaryKey" \
        '{ if ($1==primaryKey) { found=1; exit } } END { if (!found) exit 1 }'/Databases/$mydb/$tableName; then
        echo "Primary key '$primaryKey' does not exist in table 'Databases/$mydb/$tableName'."
    else
        echo "Primary key '$primaryKey' exists in table '$tableName'."
    fi
}

insertspecefic(){

declare -i i=1
echo  "" >> ./Databases/$mydb/$tableName

# Insert the PK seperatly 
read -p "Your new PK: " primaryKey

PK_exist


Ncol=$(sed -n '3p' Databases/$mydb/$tableName-metadata ) # N of col entered by user when table creation 
while (true)
do  #1 4

    if ((  $i != $Ncol ));then
    #skip the first col = PK 
    s=$(sed -n '1p' Databases/$mydb/$tableName | awk -F: -v i=$(($i+1)) '{print $i}') # store table header into S
    echo -n "please enter $s = "
    read -p "" input
    
    echo -n $input":" >> ./Databases/$mydb/$tableName
    i=$i+1
    else
        cat Databases/$mydb/$tableName
        break
    fi

done
}

insertRow(){
    echo "please enter you data in order as follows and make sure that primary key is a unique value your primary key is $pk"
    s=$(sed -n /name/p Databases/$mydb/$tableName)
    echo "insert into $s"
    read -p " " newRow
    echo  "" >> ./Databases/$mydb/$tableName
     echo -n $newRow":" >> ./Databases/$mydb/$tableName
    }
 
selectoption(){

        echo " choose the way of insert you wanna use"
    options=("insert by row" "insert one by one")
    select opt in "${options[@]}"
    do
    case $opt in
        "insert by row")
            echo "NOTE : BE CAREFUL INSERT ROW MUST BE IN SAME ORDER AS FOLLOWS OR YOU LOSE DATA CONSISTNSY"          
            insertRow
            echo " "
            bash ./TableMainMenu.sh
            ;;
        "insert one by one")
            insertspecefic
            echo " 1) Create Table       3) Drop Table         5) Select from Table  7) Update Table
                   2) List Table         4) Insert into Table  6) Delete from Table  8) Exit"
            bash ./TableMainMenu.sh
            ;;
        *) echo "invalid option $REPLY please try again" 
           echo "choose the way of insert you wanna use"
           echo "insert by row "
           echo "insert one by one" ;;
    esac
    done

    }

if [ -f Databases/$mydb/$tableName ] ;then
    selectoption


else
    echo "table not exist"
    read -p "enter table name you want insert into : " tableName
    while (true)
     do
     if [ -f Databases/$mydb/$tableName ] ;then
        selectoption
        break;
    else
        echo "table not exist"
        read -p "enter table name you want insert into: " tableName
        fi
    done
fi


echo " "
bash ./TableMainMenu.sh

# echo $metadata

# cut -d: -f 2 databases/emplyee