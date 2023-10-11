#!/usr/bin/env bash

if [ ! -f /usr/local/bin/terraform ]; then
  wget -q https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
  unzip terraform_1.6.0_linux_amd64.zip -d /usr/local/bin/
fi

exit 0
