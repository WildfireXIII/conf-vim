@echo off
copy .vimrc pkg\win\.vimrc
pushd pkg\lx
git add *
git commit -m %1
git push origin
popd
