-- コマンドライン引数からファイル名を取得
local filename = arg[1]

-- ファイルが指定されていない場合は終了
if not filename then
    print("Usage: lua script.lua <filename>")
    return
end

-- ファイルを開く
local file = io.open(filename, "r")

-- ファイルが開けない場合はエラーを表示して終了
if not file then
    print("Error: Unable to open file")
    return
end

local BowlingGame = require("bowling_game")
local bg = BowlingGame:new()

-- ファイルから一行ずつ読み込んで処理する
for line in file:lines() do
    -- 整数値に変換して二倍にする
    local number = tonumber(line)
    if number then
        if number < 0 then
            -- print("Error: Negative number encountered")
            break
        else
            bg:roll(number)
        end
    else
        print("Error: Invalid number encountered")
        break
    end
end

-- ファイルを閉じる
file:close()

print(bg:score())
