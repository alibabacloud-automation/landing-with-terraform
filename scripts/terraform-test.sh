#!/usr/bin/env sh
error=false

success=true
record=false
folders=$1
if  [ ! -n "$1" ] ;then
  exit 0
fi
if  [ -n "$2" ] ;then
  record=true
  folders=$(find quickstarts -maxdepth 1 -mindepth 1 -type d)
fi
for f in ${folders//,/ }
do
  f=$(echo $f | xargs echo -n)
  echo ""
  echo "====> Terraform testing in" $f
  terraform -chdir=$f init -upgrade
  ~/init_env.sh
  source ~/.terraform_profile
  echo ""
  echo "----> Plan Testing"
  cp scripts/plan.tftest.hcl $f/
  terraform -chdir=$f test test -verbose
  if [[ $? -ne 0 ]]; then
    success=false
    echo -e "\033[31m[ERROR]\033[0m: running terraform test for plan failed."
    bash scripts/generate-test-record.sh $record $f "Plan: running terraform test for plan failed."
  else
    echo ""
    echo "----> Apply Testing"
    rm -rf $f/plan.tftest.hcl
    cp scripts/apply.tftest.hcl $f/
    terraform -chdir=$f test test
    if [[ $? -ne 0 ]]; then
      success=false
      echo -e "\033[31m[ERROR]\033[0m: running terraform test for apply failed."
      bash scripts/generate-test-record.sh $record $f "Apply: running terraform test for apply failed."
    fi
    rm -rf $f/apply.tftest.hcl
  fi
  bash scripts/generate-test-record.sh $record $f
done

if [[ $success == "false" && $record == "false" ]]; then
    exit 1
fi
exit 0
