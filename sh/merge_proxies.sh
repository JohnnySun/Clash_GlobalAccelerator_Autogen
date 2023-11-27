#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p $script_dir/../gen
# 设置目标文件夹
folder_path="$script_dir/../proxies"

# 设置新的合并后的文件名
output_file="$script_dir/../gen/proxies.yaml"

# 清空或创建新的合并文件
echo "proxies:" > "$output_file"

# 递归查找指定文件夹中的所有 .yaml 文件
find "$folder_path" -type f -name "*.yaml" | while read -r file; do
  if [ -f "$file" ]; then
    echo "  # Merged by: $(basename "$file")" >> "$output_file"
    sed 's/^/  /' $file >> "$output_file"
    echo "" >> "$output_file"
  fi
done
echo "" >> "$output_file"

echo "合并完成，结果保存在 $output_file"