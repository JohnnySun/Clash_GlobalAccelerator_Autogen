#!/bin/bash
#
# Copyright 2024 Rivoreo
# Another: Johnny Sun
# Email: bmy001@gmail.com  
#
#    http://www.rivoreo.one
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

script_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p $script_dir/../gen

# 指定 <option> 所在的文件夹，默认为当前目录下的 router 文件夹
nameserver_policy_directory="$script_dir/../dns/nameserver_policy"

# 指定目标目录
dns_yaml="$script_dir/../dns/dns.yaml"

# 指定输出文件夹
output_file="$script_dir/../gen/dns.yaml"

# 函数用于执行替换并保存到输出文件夹
replace_and_save() {
  local input_file="$1"

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
    if [[ $line =~ \+\+(nameserver_policy)\+\+ ]]; then
      replace_content=""
      for file in "$nameserver_policy_directory"/*.yaml; do
        if [ -f "$file" ]; then
          replace_content+="$(echo "# Merged by: $(basename "$file")")"
          replace_content+="\n"
          replace_content+=$(<"$file")
          replace_content+="\n"
        fi
      done
      replace_content=$(echo -e "$replace_content" | sed 's/^/    /')
      # 替换整行
      content[$i]="$replace_content"
    fi
  done

  # 将结果保存到输出文件
  printf "%s\n" "${content[@]}" > "$output_file"
  echo "合并完成，结果保存在 $output_file"
}

replace_and_save "$dns_yaml"
