#!/bin/bash

cp .vimrc pkg/lx/.vimrc
cp jellybeans.vim pkg/lx
cp -r ftplugin pkg/lx
pushd pkg/lx
git add -A
git commit -m "$1"
git push origin
popd
