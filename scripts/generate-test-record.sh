#!/usr/bin/env bash

if [ "$1" == "false" ];then
  exit 0
fi

success=true
if [ -n "$3" ] ;then
  success=false
fi

fileName=$(basename $2)
testRecordFile=TestRecord/$fileName/TestRecord.md.tmp
if [ ! -d "TestRecord/${fileName}" ]; then
  mkdir -p TestRecord/$fileName
  touch $testRecordFile
fi

time=$(date -u "+%d %b %Y %H:%M UTC")
echo -e "## $time\n" > $testRecordFile
echo -e "success: ${success}\n\n### Versions\n" >> $testRecordFile

row=$(terraform version | sed -n '/^$/=')
allRow=$(terraform version | sed -n '$=')

if [ $row -ne $allRow ]; then
  version=$(terraform version | sed -n "1,${row}p")
fi
echo ${version} >> $testRecordFile
echo -e "\n### Error\n" >> $testRecordFile

if [ -n "$3" ] ;then
  echo $3 >> $testRecordFile
fi
