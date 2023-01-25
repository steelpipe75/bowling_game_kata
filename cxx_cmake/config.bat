cd /D %~dp0
if not exist build (
    mkdir build
)
cd build
cmd /K cmake -S .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ %*
