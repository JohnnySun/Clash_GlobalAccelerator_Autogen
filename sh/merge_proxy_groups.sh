#!/bin/bash
#
# Author: Your Name
# Another: Johnny Sun
# Email: bmy001@gmail.com  
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License. 

script_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p $script_dir/../gen
mkdir -p $script_dir/../gen/proxy_groups

# 指定 <option> 所在的文件夹，默认为当前目录下的 router 文件夹
routing_table_directory="$script_dir/../proxy_groups/routing"

# 指定目标目录
source_directory="$script_dir/../proxy_groups"

# 指定输出文件夹
replace_output_folder="$script_dir/../gen/proxy_groups"

# 函数用于执行替换并保存到输出文件夹
replace_and_save() {
  local input_file="$1"
  local output_file="$replace_output_folder/$(basename "$input_file")"

  # 创建输出文件夹
  mkdir -p "$(dirname "$output_file")"

  # 读取输入文件内容并存储为数组
  content=()
  while IFS= read -r line || [[ -n "$line" ]]; do
    content+=("$line")
  done < "$input_file"

  # 查找 ++filename++ 形式的内容并替换整行
  for ((i=0; i<${#content[@]}; i++)); do
    line="${content[$i]}"
    if [[ $line =~ \+\+([^+]+)\+\+ ]]; then
      match="${BASH_REMATCH[0]}"  # 匹配到的 ++filename++
      filename="${BASH_REMATCH[1]}.router"  # 提取的 filename

      # 构建文件路径
      file_path="$routing_table_directory/$filename"

      # 检查文件是否存在
      if [ -f "$file_path" ]; then
        # 读取目标文件的内容

        replace_content+="$(echo "# Merged by: $(basename "$file_path")")"
        replace_content+="\n"
        replace_content=$(<"$file_path")
        replace_content+="\n"
        replace_content=$(echo -e "$replace_content" | sed 's/^/    /')
        # 替换整行
        content[$i]="$replace_content"
      else
        echo "File $file_path not found."
        break  # 如果文件不存在，退出循环
      fi
    fi
  done

  # 将结果保存到输出文件
  printf "%s\n" "${content[@]}" > "$output_file"
}

# 递归查找指定文件夹中的所有 .yaml 文件
find "$source_directory" -type f -name "*.yaml" | while read -r file; do
  replace_and_save "$file"
done

# 合并文件开始

# 设置新的合并后的文件名
output_file="$script_dir/../gen/proxy-groups.yaml"

# 清空或创建新的合并文件
echo "proxy-groups:" > "$output_file"

# 查找所有以.yaml结尾的文件并拼接到新文件中
for file in "$replace_output_folder"/*.yaml; do
  if [ -f "$file" ]; then
    echo "# Merged by: $(basename "$file")" >> "$output_file"
    sed 's/^/  /' $file >> "$output_file"
    echo "" >> "$output_file"
  fi
done

echo "合并完成，结果保存在 $output_file"

