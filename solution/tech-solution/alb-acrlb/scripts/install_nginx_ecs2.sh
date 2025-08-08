#!/bin/sh
echo "Hello World ! This is ECS02." > index.html
nohup python3 -m http.server 80 &