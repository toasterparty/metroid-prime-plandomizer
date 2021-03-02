@echo off
cd ../../randomprime
cargo build
pause
cd ..
echo Packaging release for windows...
cd release
if exist win rmdir /Q /S win
mkdir win
cd win
mkdir metroid-prime-plandomizer
cd metroid-prime-plandomizer
mkdir doc
mkdir plandos
cd ..\..\..
copy randomprime\target\debug\randomprime_patcher.exe release\win\metroid-prime-plandomizer\plandomizer_patcher.exe /Y
copy README.md release\win\metroid-prime-plandomizer /Y
copy tools\win\patch.bat release\win\metroid-prime-plandomizer  /Y
xcopy doc release\win\metroid-prime-plandomizer\doc /Y /E
xcopy plandos release\win\metroid-prime-plandomizer\plandos /Y /E
cd release\win
tar.exe -a -c -f metroid-prime-plandomizer-vX.X-windows.zip metroid-prime-plandomizer
