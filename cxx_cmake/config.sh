if [ ! -e build ]; then
    mkdir build
fi
cd build
cmake -S .. -DCMAKE_CXX_COMPILER=clang++
