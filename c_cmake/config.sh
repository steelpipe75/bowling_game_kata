if [ ! -e build ]; then
    mkdir build
fi
cd build
cmake -S .. -DCMAKE_C_COMPILER=clang $*
