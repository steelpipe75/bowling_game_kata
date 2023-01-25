cd /D %~dp0
if not exist build (
    mkdir build
)
cd build
cmd /K cmake -S .. -DCMAKE_C_COMPILER=clang %*
