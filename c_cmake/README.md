# bowling_game_kata : c_cmake

C言語 + CMake で ボーリングのスコア計算

## cmakeを使ったビルド/ctestによるテスト
```
cmake -S . -B build
cd build
cmake --build .
ctest
```

## CI

[![CMake on multiple platforms c_cmake](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/cmake-multi-platform_c_make.yml/badge.svg)](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/cmake-multi-platform_c_make.yml)
[![CodeQL c_cmake](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/codeql_c_cmake.yml/badge.svg)](https://github.com/steelpipe75/bowling_game_kata/actions/workflows/codeql_c_cmake.yml)

## その他 : ビルドツール/コンパイラを指定してビルドする例

### ninja
```
cmake -S . -B build/Ninja -G Ninja
cd build/Ninja
ninja
```

### clang
```
cmake -S . -B build/clang -DCMAKE_C_COMPILER=clang
cd build/clang
make
```

### Visual Studio 2017
```
cmake -S . -B build/vs2017 -G "Visual Studio 15 2017"
cd build/vs2017
cmake --build .
```
