#!/bin/bash

if ! grep -q "export USER='Hello'" ~/.bashrc; then #Search "export USER='Hello'" in the file and if does not exist then
    echo "export USER='Hello'" >> ~/.bashrc #Set the Environment variable USER to Hello
fi #End If

if ! grep -q "export PASSWORD='Pass@1234'" ~/.bashrc; then #Search "export PASSWORD='Pass@1234'" in the file and if does not exist then
    echo "export PASSWORD='Pass@1234'" >> ~/.bashrc #Set the Environment variable PASSWORD USER to Hello
fi #End If

echo "Please enter 'source ~/.bashrc' in the shell to update the changes in the file"

#Way to run the script : ./setting_env.sh
