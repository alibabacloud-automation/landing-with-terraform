#!/usr/bin/env sh

f=$1
success=true
exitCode=0

f=$(echo $f | xargs echo -n)
f="${f%/}"

echo ""
echo "====> Terraform testing in" $f

# set up prerequisite resources
varfile=""
if [ -d "$f/prepare" ]; then
  echo ""
  echo " ====> Found prepare directory. Creating prerequisite resources in $f/prepare"
  terraform -chdir=$f/prepare init -upgrade >/dev/null
  if [[ $? -ne 0 ]]; then
    success=false
    exitCode=1
    echo -e "\033[31m[ERROR]\033[0m: running terraform init in prepare directory failed."
    bash scripts/generate-test-record.sh $f "Prepare Init: running terraform init in prepare directory failed."
  else
    terraform -chdir=$f/prepare apply -auto-approve >/dev/null
    if [[ $? -ne 0 ]]; then
      success=false
      exitCode=3
      echo -e "\033[31m[ERROR]\033[0m: running terraform apply in prepare directory failed."
      bash scripts/generate-test-record.sh $f "Prepare Apply: running terraform apply in prepare directory failed."
      terraform -chdir=$f/prepare destroy -auto-approve >/dev/null
    else
      echo -e "\033[32m - prepare apply: success\033[0m"
      terraform -chdir=$f/prepare output > $f/prepare/terraform.tfvars
      varfile="-var-file=./prepare/terraform.tfvars"
    fi
  fi
fi
if [[ $success == "false" ]]; then
  rm -rf $f/prepare/.terraform
  rm -rf $f/prepare/.terraform.lock.hcl
  exit $exitCode
fi


terraform -chdir=$f init -upgrade >/dev/null
if [[ $? -ne 0 ]]; then
  success=false
  exitCode=1
  echo -e "\033[31m[ERROR]\033[0m: running terraform init failed."
  bash scripts/generate-test-record.sh $f "Init: running terraform init failed."
else
  echo ""
  echo " ----> Plan Testing"
  terraform -chdir=$f plan $varfile >/dev/null
  if [[ $? -ne 0 ]]; then
    success=false
    exitCode=2
    echo -e "\033[31m[ERROR]\033[0m: running terraform plan failed."
    bash scripts/generate-test-record.sh $f "Plan: running terraform plan failed."
  else
    echo -e "\033[32m - plan check: success\033[0m"
    echo ""
    echo " ----> Apply Testing"
    terraform -chdir=$f apply -auto-approve $varfile >/dev/null 
    if [[ $? -ne 0 ]]; then
      success=false
      exitCode=3
      echo -e "\033[31m[ERROR]\033[0m: running terraform apply failed."
      bash scripts/generate-test-record.sh $f "Apply: running terraform apply failed."
    else
        echo -e "\033[32m - apply check: success\033[0m"
        echo ""
        echo -e " ----> Apply Diff Checking\n"
        terraform -chdir=$f plan $varfile -detailed-exitcode
        if [[ $? -ne 0 ]]; then
          success=false
          exitCode=4
          echo -e "\033[31m[ERROR]\033[0m: running terraform plan for checking diff failed."
          bash scripts/generate-test-record.sh $f "Checking diff: running terraform plan for checking diff failed."
        else
          echo -e "\033[32m - apply diff check: success\033[0m"
          echo ""
          if [ "$2" = "weekly" ]; then
            go run scripts/import_tfer_check.go $f
          fi
        fi
    fi
    echo ""
    echo " ----> Destroying"
    terraform -chdir=$f destroy $varfile -auto-approve >/dev/null 
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

  rm -rf $f/.terraform
  rm -rf $f/.terraform.lock.hcl
fi

# destroy prerequisite resources
if [ -d "$f/prepare" ]; then
  echo ""
  echo " ====> Destroying prerequisite resources in $f/prepare"
  terraform -chdir=$f/prepare destroy -auto-approve >/dev/null
  if [[ $? -ne 0 ]]; then
    success=false
    exitCode=5
    echo -e "\033[31m[ERROR]\033[0m: running terraform destroy in prepare directory failed."
    bash scripts/generate-test-record.sh $f "Prepare Destroy: running terraform destroy in prepare directory failed."
  else
    echo -e "\033[32m - prepare destroy: success\033[0m"
  fi
  rm -rf $f/prepare/.terraform
  rm -rf $f/prepare/.terraform.lock.hcl
fi


if [[ $success == "true" ]]; then
  bash scripts/generate-test-record.sh $f
fi
echo -e "\n"

exit $exitCode