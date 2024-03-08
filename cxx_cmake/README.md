# bowling_game_kata : cxx_cmake

C++ + CMake で ボーリングのスコア計算

## CI

[![CMake on multiple platforms cxx_cmake](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/cmake-multi-platform_cxx_cmake.yml/badge.svg)](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/cmake-multi-platform_cxx_cmake.yml)
[![CodeQL cxx_cmake](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/codeql_cxx_cmake.yml/badge.svg)](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/codeql_cxx_cmake.yml)

## ビルド方法の例

### ninja
```
cmake -S . -B build/Ninja -G Ninja
cd build/Ninja
ninja
```

### clang
```
cmake -S . -B build/clang -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
cd build/clang
make
```

### Visual Studio 2017
```
cmake -S . -B build/vs2017 -G "Visual Studio 15 2017"
cd build/vs2017
cmake --build .
```
