@echo off
cd ../../randomprime
cargo build --release
cd ..
echo Packaging release for windows...
if exist release rmdir /Q /S release
mkdir release
cd release
mkdir metroid-prime-plandomizer
cd ..
copy randomprime\target\release\randomprime_patcher.exe release\metroid-prime-plandomizer\plandomizer_patcher.exe /Y
copy README.md release\metroid-prime-plandomizer /Y
copy tools\win\patch.bat release\metroid-prime-plandomizer  /Y
xcopy plandos release\metroid-prime-plandomizer /Y /E
cd release
tar.exe -a -c -f metroid-prime-plandomizer-vX.X-windows.zip metroid-prime-plandomizer
pause
