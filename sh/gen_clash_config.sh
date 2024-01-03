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
rm -rf $script_dir/../gen
bash $script_dir/copy_cloudflare_wrap.sh $2 $3
bash $script_dir/merge_dns.sh
bash $script_dir/merge_proxies.sh
bash $script_dir/merge_proxy_groups.sh
bash $script_dir/merge_proxy_providers.sh $1
bash $script_dir/merge_rule_providers.sh
bash $script_dir/merge_rules.sh
bash $script_dir/merge_final_config.sh
