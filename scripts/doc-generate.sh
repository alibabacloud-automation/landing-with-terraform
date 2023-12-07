#!/usr/bin/env bash

if [ $# -eq 0 ];then
    exampleDir=$(find ./quickstarts -maxdepth 2 -mindepth 2 -type d)
    # echo $exampleDir
    for file in $exampleDir;do
        # echo $file
        if [ -f $file/"main.tf" ];then
            terraform-docs $file -c scripts/.terraform-docs.yml
            terraform fmt $file
        fi
    done
else
    for arg in "$@"
    do  
        if [ -f $arg/"main.tf" ];then
            terraform-docs $arg -c scripts/.terraform-docs.yml
            terraform fmt $file
        else
            exampleDir=$(find $arg -maxdepth 2 -mindepth 1 -type d)
            for file in $exampleDir;do
                if [ -f $file/"main.tf" ];then
                    terraform-docs $file -c scripts/.terraform-docs.yml
                    terraform fmt $file
                fi
            done
        fi
    done
fi






