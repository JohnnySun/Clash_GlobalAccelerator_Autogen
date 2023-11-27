#!/bin.bash
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
mkdir -p $script_dir/../gen/config

config_dir="$script_dir/.."
gen_dir="$script_dir/../gen"
output_file="$gen_dir/config/clash_config.yaml"

echo "# Clash Config Generated Time: $(date +"%Y-%m-%d %H:%M:%S")" > $output_file
cat $config_dir/start.yaml >> "$output_file"
echo "" >> "$output_file"

# 查找所有以.yaml结尾的文件并拼接到新文件中
for file in "$gen_dir"/*.yaml; do
  if [ -f "$file" ]; then
    echo "# Merged by: $(basename "$file")" >> "$output_file"
    cat $file >> "$output_file"
    echo "" >> "$output_file"
  fi
done

echo "合并完成，结果保存在 $output_file"