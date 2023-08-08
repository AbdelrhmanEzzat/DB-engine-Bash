Bash Shell Script Database Management System (DBMS):

The Project aim to develop DBMS, that will enable users to store and retrieve the data from Hard-disk.

The Project Features:
The Application will be CLI Menu based app, that will provide to user this Menu items:
Main Menu:
- Create Database
- List Databases
- Connect To Databases
- Drop Database

Upon user Connect to Specific Database, there will be new Screen with this Menu:
- Create Table 
- List Tables
- Drop Table
- Insert into Table
- Select From Table
- Delete From Table
- Update Table

Hints:
- The Database will store as Directory on Current Script File
- The Select of Rows displayed in screen/terminal in  an Accepted/Good Format
- Ask about columns datatypes in create table and check on them in both insert and update
-Ask about primary key in create table and check for it in the insert into table

The Bonus:
- Make the App to accept SQL Code or Use GUI instead of the above menu based






#!/bin/bash

# Prompt the user for the old value
read -p "Enter the old value: " old_value

# Prompt the user for the new value
read -p "Enter the new value: " new_value

# Prompt the user for the file path
read -p "Enter the file path: " file_path

# Check if the file exists
if [ -f "$file_path" ]; then
    # Replace the old value with the new value in the file
    sed -i "s/$old_value/$new_value/g" "$file_path"
    echo "Value '$old_value' replaced with '$new_value' successfully in the file!"
else
    echo "File not found!"
fi
To use this script, save it to a file (e.g., replace_value.sh), make it executable (chmod +x replace_value.sh), and then run it (./replace_value.sh). It will prompt you for the old value, the new value, and the file path. It will then replace all occurrences of the old value with the new value in the specified file.

Please note that you need to provide the correct old value, new value, and file path when prompted.

Let me know if you need any further assistance!
