-- 必要なモジュールを読み込む
local BowlingGame = require("bowling_game")
local luaunit = require("luaunit")

-- BowlingGameクラスのユニットテスト
TestBowlingGame = {}

-- セットアップ関数（各テストケースの前に実行）
function TestBowlingGame:setUp()
    -- ボーリングゲームのインスタンスを作成
    self.game = BowlingGame:new()
end

function TestBowlingGame:testAllZeros()
    for i = 1, 20 do
        self.game:roll(0)
    end
    luaunit.assertEquals(self.game:score(), 0)
end

function TestBowlingGame:testAllOnes()
    for i = 1, 20 do
        self.game:roll(1)
    end
    luaunit.assertEquals(self.game:score(), 20)
end

function TestBowlingGame:testOneSpare()
    self.game:roll(5)
    self.game:roll(5)
    self.game:roll(3)
    for i = 1, 17 do
        self.game:roll(0)
    end
    luaunit.assertEquals(self.game:score(), 16)
end

function TestBowlingGame:testOneStrike()
    self.game:roll(10)
    self.game:roll(3)
    self.game:roll(4)
    for i = 1, 16 do
        self.game:roll(0)
    end
    luaunit.assertEquals(self.game:score(), 24)
end

function TestBowlingGame:testPerfectGame()
    for i = 1, 12 do
        self.game:roll(10)
    end
    luaunit.assertEquals(self.game:score(), 300)
end

-- テストの実行
luaunit.run()
