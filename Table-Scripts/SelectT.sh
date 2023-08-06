#!/usr/bin/bash
read -p "what is database name " DBname
read -p "Enter table name you want to select " tableName

#must make cd after every function execute
selectcolumn(){
    read -p "please enter column you want to select " columnName
    x=$(sed -n /$columnName/p ../Databases/$DBname/$tableName)
        if [[ $columnName ]] && [[ $x ]];then

            echo "select $columnName from $tableName"
            awk -v columnName=$columnName '
            BEGIN{FS=":" ; columnName=columnName; y=0}
            {
            i=1
            while(i<=NF){ 
            if ($i==col)
            {
            y=i
            }
            i++
            }
            print $y
            }
            ' ../Databases/$DBname/$tableName
    
    else
        echo "coloumn not found"
        selectcolumn
    fi

}

selecttable(){

    if [ -f ../Databases/$DBname/$tableName ] ;then
    echo "what do you want to select all or column?"
    options=("if All choose >>> 1" "if column >>> 2")
    select op in "${options[@]}"
    do
    case $op in
        "if All choose >>> 1")
            echo "Select all from $tableName"          
            cat ../Databases/$DBname/$tableName
            break;
            ;;
        "if column >>> 2")
            selectcolumn
      
            break;
            ;;
        *) 
           echo "invalid option $REPLY try again" 
           echo "what do you want to select all or column?"
           echo "if All choose> >>1"
           echo "if columnchoose >>>2" 
           ;;
    esac
    done
    else
        echo "table not exist"
        read -p "Enter table name you want to select " tableName

            while (true)
            do
                if [ -f Databases/$DBname/$tableName ] ;then
                selecttable
                break;
            else
                echo "table not exist"
                read -p "Enter table name you want select " tableName
                fi
            done
    fi

}

selecttable
echo " "
bash ./Table-Menu.sh