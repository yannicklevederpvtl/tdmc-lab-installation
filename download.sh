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

if [ ! -f /usr/local/bin/om ]; then
  echo "Installing OM CLI"
  wget -q https://github.com/pivotal-cf/om/releases/download/7.14.0/om-linux-amd64-7.14.0
  sudo install om-linux-amd64-7.14.0 /usr/local/bin/om
  rm -f om-linux-amd64-7.14.0
  om --version
fi

if [ ! -f /usr/local/bin/ytt ]; then
  echo "Installing YTT"
  wget -O- https://carvel.dev/install.sh > installcarvel.sh
  sudo bash installcarvel.sh  
  rm -f installcarvel.sh
  ytt --version
fi

if [ ! -f /bin/pandoc ]; then
  echo "Installing Pandoc"
  wget -q https://github.com/jgm/pandoc/releases/download/3.6.3/pandoc-3.6.3-1-amd64.deb
  sudo sudo dpkg -i ./pandoc-3.6.3-1-amd64.deb
  rm -f ./pandoc-3.6.3-1-amd64.deb
  pandoc --version
fi

if [ ! -f /usr/local/bin/tdmc-installer ]; then
  echo "Downloading TDMC Installer"
  om download-product -p data-mgmt-console -o ./ --file-glob 'tdmc-installer-1.0.0-82f3a9.tar' --product-version 1.0.0 --pivnet-api-token $config_pivnetApiToken 
  echo "Installing TDMC Installer"
  mkdir ./tdmc-installer
  tar -xvf tdmc-installer-1.0.0-82f3a9.tar -C ./tdmc-installer 
  sudo install ./tdmc-installer/bin/tdmc-installer-linux-amd64 /usr/local/bin/tdmc-installer
  rm -f tdmc-installer-1.0.0-82f3a9.tar
  rm -f download-file.json
fi
