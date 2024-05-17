#!/usr/bin/env sh

f=$1
success=true

f=$(echo $f | xargs echo -n)

exitCode=0
echo ""
echo "====> Terraform testing in" $f
terraform -chdir=$f init -upgrade >/dev/null
if [[ $? -ne 0 ]]; then
  success=false
  exitCode=1
  echo -e "\033[31m[ERROR]\033[0m: running terraform init failed."
  bash scripts/generate-test-record.sh $f "Init: running terraform init failed."
else
  echo ""
  echo " ----> Plan Testing"
  terraform -chdir=$f plan >/dev/null
  if [[ $? -ne 0 ]]; then
    success=false
    exitCode=2
    echo -e "\033[31m[ERROR]\033[0m: running terraform plan failed."
    bash scripts/generate-test-record.sh $f "Plan: running terraform plan failed."
  else
    echo -e "\033[32m - plan check: success\033[0m"
    echo ""
    echo " ----> Apply Testing"
    terraform -chdir=$f apply -auto-approve >/dev/null 
    if [[ $? -ne 0 ]]; then
      success=false
      exitCode=3
      echo -e "\033[31m[ERROR]\033[0m: running terraform apply failed."
      bash scripts/generate-test-record.sh $f "Apply: running terraform apply failed."
    else
        echo -e "\033[32m - apply check: success\033[0m"
        echo ""
        echo -e " ----> Apply Diff Checking\n"
        terraform -chdir=$f plan -detailed-exitcode
        if [[ $? -ne 0 ]]; then
          success=false
          exitCode=4
          echo -e "\033[31m[ERROR]\033[0m: running terraform plan for checking diff failed."
          bash scripts/generate-test-record.sh $f "Checking diff: running terraform plan for checking diff failed."
        else
          echo -e "\033[32m - apply diff check: success\033[0m"
        fi
    fi
    echo ""
    echo " ----> Destroying"
    terraform -chdir=$f destroy -auto-approve >/dev/null 
    if [[ $? -ne 0 ]]; then
      success=false
      if [[ $exitCode -eq 0 ]]; then
        exitCode=5
      fi
      echo -e "\033[31m[ERROR]\033[0m: running terraform destroy failed."
      bash scripts/generate-test-record.sh $f "Destroy: running terraform destroy failed."
    else
      echo -e "\033[32m - destroy: success\033[0m"
    fi
  fi

  if [[ $success == "true" ]]; then
    bash scripts/generate-test-record.sh $f
  fi

  rm -rf $f/.terraform
  rm -rf $f/.terraform.lock.hcl
fi

echo -e "\n"

exit $exitCode