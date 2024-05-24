#!/usr/bin/env sh

root=$1
f=$2
exitCode=0
success=true
echo ""
echo "====> Import testing in" $f 
cp -r $root/.terraform $f
cp $root/.terraform.lock.hcl $f
cp $root/provider.tf $f
if [ $? -ne 0 ]; then
  success=false
  exitCode=1
  echo -e "\033[31m[ERROR]\033[0m: copy terraform files failed."
  exit $exitCode
fi

echo ""
echo " ----> import pre check"
importCheckLog=$f/import-pre-check.log
planResult=$({ terraform -chdir=${f} plan -out=tf.tfplan -generate-config-out=generate.tf  -no-color; } > ${importCheckLog})
haveDiff=$(cat ${importCheckLog} | grep "0 to add, 0 to change, 0 to destroy")
if [[ $planResult -ne 0 || ${haveDiff} == "" ]]; then
  success=false
  exitCode=2
  echo -e "\033[31m[ERROR]\033[0m: running import pre check failed."
else
  echo -e "\033[32m - pre check: success\033[0m"
  echo ""
  echo " ----> import apply check"
  terraform -chdir=$f apply tf.tfplan
  if [ $? -ne 0 ]; then
    success=false
    exitCode=3      
    echo -e "\033[31m[ERROR]\033[0m: running import apply failed."
  else
    echo -e "\033[32m - import: success\033[0m"
    echo ""
    echo " ----> import diff check"
    terraform -chdir=$f plan
    if [ $? -ne 0 ]; then
      success=false
      exitCode=4
      echo -e "\033[31m[ERROR]\033[0m: running import diff check failed."
    else
      echo -e "\033[32m - import diff check: success\033[0m"
    fi
  fi
fi

rm -rf $f

exit $exitCode


