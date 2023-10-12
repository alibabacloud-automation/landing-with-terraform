#!/usr/bin/env bash
error=false

success=true
folders=$1
for f in ${folders//,/ }
do
  f=$(echo $f | xargs echo -n)
  echo "===> Terraform testing in" $f
  terraform -chdir=$f init -upgrade
  ~/.init-env
  source ./.terraform_profile
  echo "---> plan testing"
  echo ""
  cp scripts/plan.tftest.hcl $f/
  terraform -chdir=$f test test -verbose
  if [[ $? -ne 0 ]]; then
    success=false
    echo -e "\033[31m[ERROR]\033[0m: running terraform test for plan failed."
  else
    echo "---> plan testing"
    echo ""
    rm -rf scripts/plan.tftest.hcl
    cp scripts/apply.tftest.hcl $f/
    terraform -chdir=$f test test
    if [[ $? -ne 0 ]]; then
      success=false
      echo -e "\033[31m[ERROR]\033[0m: running terraform test for apply failed."
    fi
    rm -rf scripts/apply.tftest.hcl
  fi
done

if [[ $success == "false" ]]; then
  exit 1
fi
exit 0
