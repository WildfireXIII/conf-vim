@echo off
copy _vimrc pkg\win\_vimrc
pushd pkg\win
git add *
git commit -m %1
git push origin
popd
