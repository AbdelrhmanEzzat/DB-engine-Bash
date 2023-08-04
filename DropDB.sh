#!/bin/bash
read -p "Enter the DataBase you want To Remove : " Removed
cd Databases/

if [[ -d $Removed ]];then
rm -r $Removed
echo "Removed Successfully"
else 
    echo "No DataBase"
    read -p "Enter the DataBase you want To Remove : " Removed
fi