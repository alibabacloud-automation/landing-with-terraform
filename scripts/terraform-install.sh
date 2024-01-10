#!/usr/bin/env bash

if [ ! -f /usr/bin/terraform ]; then
  echo "terraform does not exist!"
  wget -q https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
  unzip terraform_1.6.0_linux_amd64.zip -d /usr/bin/
else
  echo "terraform exists!"
fi


exit 0
