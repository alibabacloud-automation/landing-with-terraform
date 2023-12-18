#!/usr/bin/env bash

unset TF_LOG_PATH

if [ "$1" == "false" ];then
  exit 0
fi

success=true
if [ -n "$3" ] ;then
  success=false
fi

subcategory=$(dirname $2)
subcategory=$(basename $subcategory)
fileName=$subcategory/$(basename $2)

testRecordFile=TestRecord/$fileName/TestRecord.md.tmp
if [ ! -d "TestRecord/${fileName}" ]; then
  mkdir -p TestRecord/$fileName
  touch $testRecordFile
fi

time=$(date -u "+%d %b %Y %H:%M UTC")
echo -e "## $time\n" > $testRecordFile
echo -e "success: ${success}\n\n### Versions\n" >> $testRecordFile

cd $2
row=$(terraform version | sed -n '/^$/=')
if [ -n "$row" ]; then
  version=`echo "$(terraform version | sed -n "1,${row}p")"`
else
  version=`echo "$(terraform version)"`
fi
cd - >/dev/null 2>&1

echo "${version}" >> $testRecordFile
echo -e "\n### Error\n" >> $testRecordFile

if [ -n "$3" ] ;then
  echo $3 >> $testRecordFile
fi

echo "generate-test-record ${testRecordFile} successfully" 