#!/usr/bin/env sh


root=$1
resourceType=$2
id=$3
output=$4
filter=$2".id="$3

exitCode=0

echo ""
echo "  ====> Terraformer testing in" $output


echo ""
echo "   ----> terraformer import check"
export TF_DATA_TFER_DIR="$(pwd)/${root}/.terraform"

mkdir -p $output
importCheckLog=$output/import-pre-check.log
importResult=$({ terraformer import alicloud -o=${output} -r=${resourceType} --terraform-version=1.6.0 --path-pattern=${output} --filter=${filter}; } > ${importCheckLog})
notSupported=$(cat ${importCheckLog} | grep "not supported service") 
haveNoResource=$(cat ${importCheckLog} | grep "Number of resources is zero")
if [[ $notSupported ]];then
  exitCode=1
  echo -e "\nError: terraformer not support this resourceType: alicloud_${resourceType}." >&2
  exit $exitCode
elif [[ $importResult -ne 0 || $haveNoResource ]];then
  exitCode=2
  echo -e "Error: terraformer import failed." >&2
  if [[ $haveNoResource ]];then
    echo -e "Error: The number of imported resources is zero." >&2
  fi
  cat ${importCheckLog}
  exit $exitCode
fi


echo ""
echo "   ----> terraformer import diff check"
terraform -chdir=$output state replace-provider -auto-approve "registry.terraform.io/-/alicloud" "aliyun/alicloud" >/dev/null 2>&1
cp -r $root/.terraform $output && cp $root/.terraform.lock.hcl $output && cp $root/provider.tf $output
if [ $? -ne 0 ]; then
  terraform -chdir=$output init -upgrade >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    exitCode=3
    echo -e "Error: terraformer import diff failed. terraform init failed." >&2
    exit $exitCode
  fi
fi

terraform -chdir=$output refresh >/dev/null 2>&1
terraform -chdir=${output} plan -detailed-exitcode -no-color >/dev/null
if [ $? -ne 0 ]; then
  exitCode=3
  echo -e "Error: terraformer import diff failed." >&2
  exit $exitCode
fi

rm -rf $output

exit $exitCode

