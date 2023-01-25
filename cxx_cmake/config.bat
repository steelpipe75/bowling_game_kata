cd /D %~dp0
if not exist build (
    mkdir build
)
cd build
cmd /K cmake -S .. -G Ninja -DCMAKE_CXX_COMPILER=clang++ %*
