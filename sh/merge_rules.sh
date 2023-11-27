#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p $script_dir/../gen
# 设置目标文件夹
folder_path="$script_dir/../rules"

# 设置新的合并后的文件名
output_file="$script_dir/../gen/rules.yaml"

# 清空或创建新的合并文件
echo "rules:" > "$output_file"

# 递归查找指定文件夹中的所有 .yaml 文件
find "$folder_path" -type f -name "*.rules" | sort | while read -r file; do
  if [ -f "$file" ]; then
    #echo "  # Merged by: $(basename "$file")" >> "$output_file"
    grep -vE '^\s*$|^\s*#' $file >> "$output_file.tmp"
    sed 's/^/  - /' $output_file.tmp >> "$output_file"
    echo "" >> "$output_file"
    rm $output_file.tmp
  fi
done

echo "  # Default Router" >> "$output_file"
echo "  - MATCH, FINAL" >> "$output_file"
echo "" >> "$output_file"

echo "合并完成，结果保存在 $output_file"