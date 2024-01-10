#!/usr/bin/env bash

success=true
if [ -n "$2" ] ;then
  success=false
fi

subcategory=$(dirname $1)
subcategory=$(basename $subcategory)
fileName=$subcategory/$(basename $1)

testRecordFile=TestRecord/$fileName/TestRecord.md.tmp
if [ ! -d "TestRecord/${fileName}" ]; then
  mkdir -p TestRecord/$fileName
  touch $testRecordFile
fi

time=$(date -u "+%d %b %Y %H:%M UTC")
echo -e "## $time\n" > $testRecordFile
echo -e "success: ${success}\n\n### Versions\n" >> $testRecordFile

cd $1
row=$(terraform version | sed -n '/^$/=')
if [ -n "$row" ]; then
  version=`echo "$(terraform version | sed -n "1,${row}p")"`
else
  version=`echo "$(terraform version)"`
fi
cd - >/dev/null 2>&1

echo "${version}" >> $testRecordFile
echo -e "\n### Error\n" >> $testRecordFile

if [ -n "$2" ] ;then
  echo $2 >> $testRecordFile
fi
