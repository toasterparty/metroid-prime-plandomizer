@echo off
if not exist world_layout.json (
    echo Error: world_layout.json could not be found!
    pause
    exit
)

if not exist prime.iso (
    echo Error: prime.iso could not be found!
    pause
    exit
)

cmd /C "set RUST_BACKTRACE=1 && plandomizer_patcher.exe --profile world_layout.json"
