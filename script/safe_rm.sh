#!/bin/bash

# 使用rm删除文件或文件夹的时候会提示
# Prompt for confirmation if the user requests a recursive delete
if [[ "$@" == *"-r"* ]] || [[ "$@" == *"--recursive"* ]]; then
    # read -p "This command will recursively delete files and folders. Are you sure you want to proceed? [y/N] " confirm
    echo -n "This command will recursively delete files and folders. Are you sure you want to proceed? [y/N] "
    read confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Operation canceled."
        exit 1
    fi
fi

/bin/rm -i "$@"
