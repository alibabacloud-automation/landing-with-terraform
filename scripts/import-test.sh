#!/usr/bin/env sh

root=$1
f=$2
exitCode=0
success=true
echo ""
echo "  ====> Import testing in" $f

# initialize
cp -r $root/.terraform $f && cp $root/.terraform.lock.hcl $f && cp $root/provider.tf $f
if [ $? -ne 0 ]; then
  terraform -chdir=$f init -upgrade
  if [ $? -ne 0 ]; then
    success=false
    exitCode=1
    echo -e "Error: terraform init failed." >&2
    rm -rf $f
    exit $exitCode
  fi
fi

# test
echo ""
echo "   ----> import pre check"
importCheckLog=$f/import-pre-check.log
planResult=$({ terraform -chdir=${f} plan -out=tf.tfplan -generate-config-out=generate.tf  -no-color; } > ${importCheckLog})
haveDiff=$(cat ${importCheckLog} | grep "0 to add, 0 to change, 0 to destroy")
if [[ $planResult -ne 0 || ${haveDiff} == "" ]]; then
  success=false
  exitCode=2
  echo -e "Error: terraform import pre check failed." >&2
  cat ${importCheckLog} >&1
else
  echo ""
  echo "   ----> import apply check"
  terraform -chdir=$f apply tf.tfplan >/dev/null
  if [ $? -ne 0 ]; then
    success=false
    exitCode=3      
    echo -e "Error: terraform import apply failed."  >&2
  else
    echo ""
    echo "   ----> import diff check"
    terraform -chdir=$f plan >/dev/null
    if [ $? -ne 0 ]; then
      success=false
      exitCode=4
      echo -e "Error: terraform import diff check failed."  >&2
    fi
  fi
fi

rm -rf $f

exit $exitCode


