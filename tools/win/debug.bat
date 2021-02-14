@echo off
cd ../../randomprime
cargo build
cd ..
echo Packaging DEBUG release for windows...
if exist release rmdir /Q /S release
mkdir release
cd release
mkdir metroid-prime-plandomizer
cd metroid-prime-plandomizer
mkdir plandos
cd ..\..
copy randomprime\target\debug\randomprime_patcher.exe release\metroid-prime-plandomizer\plandomizer_patcher.exe /Y
copy README.md release\metroid-prime-plandomizer /Y
copy tools\win\patch-debug.bat release\metroid-prime-plandomizer  /Y
xcopy plandos release\metroid-prime-plandomizer\plandos /Y /E
cd release
tar.exe -a -c -f metroid-prime-plandomizer-vX.X-windows-DEBUG.zip metroid-prime-plandomizer
pause
