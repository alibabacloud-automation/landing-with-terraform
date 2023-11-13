#!/usr/bin/env bash

if [ ! -f /usr/bin/terraform ]; then
  echo "terraform does not exist!"
  wget -q https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
  unzip terraform_1.6.0_linux_amd64.zip -d /usr/bin/
else
  echo "terraform exists!"
fi

if [ ! -f /usr/bin/aliyun ]; then
  echo "aliyun does not exist!"
  wget -q https://github.com/aliyun/aliyun-cli/releases/download/v3.0.186/aliyun-cli-linux-3.0.186-amd64.tgz
  tar xzvf aliyun-cli-linux-3.0.186-amd64.tgz
  mv aliyun /usr/bin
else
  echo "aliyun exists!"
fi

exit 0
