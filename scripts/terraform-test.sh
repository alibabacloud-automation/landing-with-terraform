#!/usr/bin/env sh

if [ ! $# -eq 1 ];then
  exit 1
fi

f=$1
success=true

echo $f
f=$(echo $f | xargs echo -n)

echo ""
echo "====> Terraform testing in" $f
terraform -chdir=$f init -upgrade >/dev/null

echo ""
echo "----> Plan Testing"
terraform -chdir=$f plan >/dev/null
if [[ $? -ne 0 ]]; then
  success=false
  echo -e "\033[31m[ERROR]\033[0m: running terraform plan failed."
  bash scripts/generate-test-record.sh $f "Plan: running terraform plan failed."
else
  echo -e "\033[32mSuccess!\033[0m"
  echo ""
  echo "----> Apply Testing"
  terraform -chdir=$f apply -auto-approve >/dev/null 
  if [[ $? -ne 0 ]]; then
    success=false
    echo -e "\033[31m[ERROR]\033[0m: running terraform apply failed."
    bash scripts/generate-test-record.sh $f "Apply: running terraform apply failed."
  else
      echo -e "\033[32mSuccess!\033[0m"
      echo ""
      echo -e "----> Checking Diff\n"
      terraform -chdir=$f plan -detailed-exitcode
      if [[ $? -ne 0 ]]; then
        success=false
        echo -e "\033[31m[ERROR]\033[0m: running terraform plan for checking diff failed."
        bash scripts/generate-test-record.sh $f "Checking diff: running terraform plan for checking diff failed."
      else
        echo -e "\033[32mSuccess!\033[0m"
      fi
  fi
  echo ""
  echo "----> Destroying"
  terraform -chdir=$f destroy -auto-approve >/dev/null 
  if [[ $? -ne 0 ]]; then
    success=false
    echo -e "\033[31m[ERROR]\033[0m: running terraform destroy failed."
  else
    echo -e "\033[32mSuccess!\033[0m"
  fi
fi


if [[ $success == "true" ]]; then
  bash scripts/generate-test-record.sh $f
fi

if [[ $success == "false" ]]; then
    exit 1
fi
exit 0
