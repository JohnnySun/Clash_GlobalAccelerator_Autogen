#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p $script_dir/../gen
# 设置目标文件夹
folder_path="$script_dir/../proxy_providers"

# 设置新的合并后的文件名
output_file="$script_dir/../gen/proxy-providers.yaml"

# 清空或创建新的合并文件
echo "proxy-providers:" > "$output_file"

# 查找所有以.yaml结尾的文件并拼接到新文件中
for file in "$folder_path"/*.yaml; do
  if [ -f "$file" ]; then
    echo "# Merged by: $(basename "$file")" >> "$output_file.tmp"
    sed 's/^/  /' $file >> "$output_file.tmp"
    sed 's/DLER_SUBSCRIBE_TOKEN/'"$1"'/' $output_file.tmp >> "$output_file"
    echo "" >> "$output_file"
    rm $output_file.tmp
  fi
done

echo "合并完成，结果保存在 $output_file"