#!/usr/bin/env bash
set -e
set -u
set -o pipefail

parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

eval $(parse_yaml tdmc-config.yaml "config_")

./tdmc-installer/bin/credential-generator-linux-amd64 --url "tdmc.packages.broadcom.com/v1.0.0" --username $config_broadcomPortalUsername --password $config_broadcomPortalPassword
ytt -f ./tdmc-config.yaml -f ./templates/tdmc-config-install.yaml -f credential.json > ./generated/tdmc-config-generated.yaml
ytt -f ./tdmc-config.yaml -f ./templates/tdmccp-cluster.yaml > ./generated/tdmccp-cluster-generated.yaml
ytt -f ./tdmc-config.yaml -f ./templates/tdmcdp-cluster.yaml > ./generated/tdmcdp-cluster-generated.yaml

pandoc --template=./templates/instructions.md --metadata-file=tdmc-config.yaml -o ./generated/instructions.md ./templates/instructions.md


