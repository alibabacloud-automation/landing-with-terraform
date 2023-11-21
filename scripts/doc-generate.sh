#!/usr/bin/env bash

if [ $# -eq 0 ];then
    cd quickstarts
    exampleDir=$(ls ./)
    reg='^101-.*'
    for file in $exampleDir;do
        if [[ $file =~ $reg ]]
        then
            cd $file
            terraform-docs -c ../../scripts/.terraform-docs.yml .
            terraform fmt
            cd ..
        fi
    done
else
    for arg in "$@"
    do
        cd $arg
        terraform-docs -c ../../scripts/.terraform-docs.yml .
        terraform fmt
        cd ../../
    done
fi






