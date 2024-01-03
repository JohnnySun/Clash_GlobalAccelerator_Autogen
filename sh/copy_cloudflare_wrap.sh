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

output_file="$script_dir/../proxies/cloudflare_warp_proxies.yaml"
input_file="$script_dir/../cloudflare_warp_proxies.yaml"

PrivateKey64="$( echo "$1" | sed 's/[\\&*./+!]/\\&/g' )"
sed -i 's/CF_WARP_PRIVATE_KEY/'"$PrivateKey64"'/' $input_file
PublicKey64="$( echo "$2" | sed 's/[\\&*./+!]/\\&/g' )"
sed -i 's/CF_WARP_PUBLIC_KEY/'"$PublicKey64"'/' $input_file

cp $input_file $output_file