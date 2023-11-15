#!/usr/bin/env bash

git pull --rebase origin main

git config --global --add safe.directory '*'

if [ ! -d "TestRecord" ]; then
  echo "No TestRecord found, exit"
  exit 0
fi

cd TestRecord

folders=$(find ./ -maxdepth 1 -mindepth 1 -type d)
for f in $folders; do
  d=${f#"./"}

  if [ ! -f "../quickstarts/$d/TestRecord.md" ]; then
    touch ../quickstarts/$d/TestRecord.md
  fi

  echo -e "\n" >> ./$d/TestRecord.md.tmp
  cat ../quickstarts/$d/TestRecord.md >> ./$d/TestRecord.md.tmp
  cat ./$d/TestRecord.md.tmp > ../quickstarts/$d/TestRecord.md
done

cd ..
git add **/TestRecord.md