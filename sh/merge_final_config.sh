#!/bin.bash

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