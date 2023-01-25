cd /D %~dp0
if not exist build (
    mkdir build
)
cd build
cmd /K cmake -S .. -DCMAKE_CXX_COMPILER=clang++ %*
