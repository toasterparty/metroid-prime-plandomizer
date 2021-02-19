@echo off
cd ../../randomprime
cargo build
cd target\debug
cmd /C "set RUST_BACKTRACE=1 && resource_tracing ../../../prime.iso > ../../../pickup_meta.rs.in"
pause
