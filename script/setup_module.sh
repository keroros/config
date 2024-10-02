#!/bin/bash

if [ -z "$1" ]; then
  echo "Correct usage: setup <module_name>"
  exit 1
fi

module_name=$1

mkdir -p "$module_name"

mkdir -p "$module_name/QA_DIR"
cp -r /home/qidc/Nutstore/Project/config/QA_DIR/* "$module_name/QA_DIR/"

mkdir -p "$module_name/rtl"
vim --not-a-term -c 'wq' "$module_name/rtl/${module_name}.v" >/dev/null 2>&1

mkdir -p "$module_name/tb"
vim --not-a-term -c 'wq' "$module_name/tb/${module_name}_tb.v" >/dev/null 2>&1

touch "$module_name/README.md"

sed -i "s/module $module_name/module ${module_name}_tb/g" "$module_name/tb/${module_name}_tb.v"

v_file_path=$(realpath "$module_name/rtl/${module_name}.v")
tb_file_path=$(realpath "$module_name/tb/${module_name}_tb.v")

echo "$v_file_path" >> "$module_name/QA_DIR/filelist.f"
echo "$tb_file_path" >> "$module_name/QA_DIR/filelist.f"

echo "**********************************************************"
echo ""
echo "Directory structure for $module_name created successfully!"
echo ""
echo "**********************************************************"
