#!/usr/bin/bash
echo "Update Record in Table"
read -p "Enter Database name " DBname
read -p "Enter table name you want to update : " tableName

selectcolumn

selectcolumn(){
    read -p "Enter column you want to update : " col
    read -p "Enter the new data : " newdata
    s=$(sed -n "/$col/p" "Databases/$DBname/$tableName")
        if [[ $col ]] && [[ $s ]];then

            echo "select $col from $tableName"
            col=$col newdata=$newdata
            awk -v '
            BEGIN{FS=":" ; col=col ; newdata=newdata ; y=0}
            {
            i=1;
            while(i<=NF){
                if($i == $col){
                    $i=newdata;
                }
                i++
            }' "Databases/$DBname/$tableName"
    
    else
        echo "coloumn not found"
        selectcolumn
    fi

}