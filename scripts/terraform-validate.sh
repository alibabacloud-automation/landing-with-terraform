#!/usr/bin/env bash
error=false

folders=$1
for f in ${folders//,/ }
do
	f=$(echo $f | xargs echo -n)
	echo "===> Terraform validating in" $f
  terraform -chdir=$f init -upgrade
  terraform -chdir=$f validate
  if [[ $? -ne 0 ]]; then
    echo -e "\031[1m[ERROR]\031[0m: Some quickstarts codes contain errors, and please running terraform validate command before pushing."
    exit 1
  fi
done

exit 0
