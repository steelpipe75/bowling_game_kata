-- ボーリングのスコア計算クラス
local BowlingGame = {}

-- 初期化
function BowlingGame:new()
    local game = {
        rolls = {}, -- 倒したピンの数を記録する配列
        MAX_FRAMES = 10 -- 最大フレーム数
    }
    setmetatable(game, self)
    self.__index = self
    return game
end

-- 投球の記録
function BowlingGame:roll(pins)
    table.insert(self.rolls, pins) -- 倒したピンの数を配列に追加
end

-- スコア計算
function BowlingGame:score()
    local score = 0
    local rollIndex = 1 -- 現在の投球のインデックス
    local maxIndex = #self.rolls
    self:roll(0)
    self:roll(0)

    for frame = 1, self.MAX_FRAMES do
        if self:isStrike(rollIndex) then -- ストライクの場合
            score = score + self:strikeScore(rollIndex)
            rollIndex = rollIndex + 1
        elseif self:isSpare(rollIndex) then -- スペアの場合
            score = score + self:spareScore(rollIndex)
            rollIndex = rollIndex + 2
        else -- 通常の投球
            score = score + self.rolls[rollIndex] + self.rolls[rollIndex + 1]
            rollIndex = rollIndex + 2
        end
    end

    return score
end

-- ストライクのボーナス
function BowlingGame:strikeScore(rollIndex)
    return 10 + self.rolls[rollIndex + 1] + self.rolls[rollIndex + 2]
end

-- スペアのボーナス
function BowlingGame:spareScore(rollIndex)
    return 10 + self.rolls[rollIndex + 2]
end

-- ストライクかどうかの判定
function BowlingGame:isStrike(rollIndex)
    return self.rolls[rollIndex] == 10
end

-- スペアかどうかの判定
function BowlingGame:isSpare(rollIndex)
    return self.rolls[rollIndex] + self.rolls[rollIndex + 1] == 10
end

return BowlingGame
