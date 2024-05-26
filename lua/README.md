# bowling_game_kata : lua

Lua で ボーリングのスコア計算

## 環境構築(hererocksを使用)

事前にhererocksをインストールしておく(要:Python)

``` powershell
pip install hererocks
```

hererocksでlua54フォルダにLua ver5.4とLuaRocks ver3.8をインストール

``` powershell
hererocks lua54 -l "5.4" -r "3.8"
```

lua54フォルダにインストールしたものをactivate

``` powershell
.\lua54\bin\activate.ps1  
```

テスト用にLuaUnitをインストール

``` powershell
luarocks install luaunit
```

## 実行方法

``` powershell
cd .\bowling_game
lua .\main.lua ..\..\testdata\all_ones.txt
```

## テスト実行

``` powershell
cd .\bowling_game
lua .\test_bowling_game.lua
```
