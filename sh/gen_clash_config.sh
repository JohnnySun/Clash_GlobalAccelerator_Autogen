#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"
rm -rf $script_dir/../gen
bash $script_dir/merge_dns.sh
bash $script_dir/merge_proxies.sh
bash $script_dir/merge_proxy_groups.sh
bash $script_dir/merge_proxy_providers.sh $1
bash $script_dir/merge_rule_providers.sh
bash $script_dir/merge_rules.sh
bash $script_dir/merge_final_config.sh
