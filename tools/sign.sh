#!/bin/bash
channel=$1
mkdir -p tmp-crx
cp -r "testbuilds/crx$channel" "tmp-crx/crx$channel"
touch -d "$(jq -r '.date' version.json)" "tmp-crx/crx$channel"/*
chromium --pack-extension="tmp-crx/crx$channel" --pack-extension-key="$(dirname "$PWD")/4chan-xl.keys/4chan-XL.pem"
mv "tmp-crx/crx$channel.crx" "testbuilds/4chan-XL$channel.crx"
rm -r 'tmp-crx/'
