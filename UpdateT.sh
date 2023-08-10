#!/usr/bin/bash
function updateTable {
      read -p "Enter DB name you want to update: " mydb

  read -p "Enter table name you want to update: " Tname
  
  echo -e "Enter  Column name: "
  read -p "Enter Field name: "
  #This line uses awk to search for column name in the first line
  fid=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=0;i<=NF;i++){if($i=="'$field'") print i}}}' Databases/$mydb/$Tname)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    tablesMenu
  else
  #This line uses awk to search for rows in the table
    echo -e "Enter Value: "
    read -p "Enter your Value: " val
    result=$(awk 'BEGIN{FS=":"}{if ($'$fid'=="'$val'") print $'$fid'}' Databases/$mydb/$Tname 2>>./.error.log)
    if [[ $result == "" ]]
    then
      echo "Value Not Found"
      tablesMenu
    else
      echo -e "Enter field name to set: "
      read -p "Enter field set: "setField
      setFid=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' Databases/$mydb/$Tname)
      if [[ $setFid == "" ]]
      then
        echo "Not Found"
        tablesMenu
      else
        echo -e "Enter new Value to set: "
        read -p"Enter New Value: "newValue
        NR=$(awk 'BEGIN{FS=":"}{if ($'$fid' == "'$val'") print NR}' Databases/$mydb/$Tname 2>>./.error.log)
        oldValue=$(awk 'BEGIN{FS=":"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$setFid') print $i}}}' Databases/$mydb/$Tname 2>>./.error.log)
        echo $oldValue
        sed -i ''$NR's/'$oldValue'/'$newValue'/g' Databases/$mydb/$Tname 2>>./.error.log
        echo "Row Updated Successfully"
        tablesMenu
      fi
    fi
  fi
}
updateTable