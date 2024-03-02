# bowling_game_kata : cxx_cmake

C++ + CMake で ボーリングのスコア計算

## ビルド方法の例

```
cmake -S . -B build/Ninja -G Ninja
cd build/Ninja
ninja
```

```
cmake -S . -B build/vs2017 -G "Visual Studio 15 2017"
cd build/vs2017
cmake --build .
```
