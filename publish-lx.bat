@echo off
copy .vimrc pkg\lx\.vimrc
pushd pkg\lx
git add *
git commit -m %1
git push origin
popd
