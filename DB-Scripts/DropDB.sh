#!/bin/bash
read -p "Enter the DataBase you want To Remove : " Removed
cd Databases/

while (true)
do

if [[ -d $Removed ]];then
rm -r $Removed
echo "Removed Successfully"
#cd ..
    break
else 
    echo "No DataBase"
    read -p "Enter the DataBase you want To Remove : " Removed
fi

done