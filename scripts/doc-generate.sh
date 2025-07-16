#!/usr/bin/env bash

if [ $# -eq 0 ];then
    exampleDir=$(find ./quickstarts -maxdepth 2 -mindepth 2 -type d)
    techSolutionDir=$(find ./solution -maxdepth 2 -mindepth 2 -type d)
    all_dirs="$exampleDir $techSolutionDir"
    # echo $all_dirs
    for file in $all_dirs;do
        # echo $file
        if [ -f $file/"main.tf" ];then
            terraform-docs $file -c scripts/.terraform-docs.yml
            sed -i '' 's|https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/|https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/|g' $file/README.md
            terraform -chdir=$file fmt 
        fi
    done
else
    for arg in "$@"
    do  
        if [ -f $arg/"main.tf" ];then
            terraform-docs $arg -c scripts/.terraform-docs.yml
            sed -i '' 's|https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/|https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/|g' $arg/README.md 
            terraform -chdir=$arg fmt 
        else
            exampleDir=$(find $arg -maxdepth 2 -mindepth 1 -type d)
            for file in $exampleDir;do
                if [ -f $file/"main.tf" ];then
                    terraform-docs $file -c scripts/.terraform-docs.yml
                    sed -i '' 's|https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/|https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/|g' $file/README.md
                    terraform -chdir=$file fmt 
                fi
            done
        fi
    done
fi






