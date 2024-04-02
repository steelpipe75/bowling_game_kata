type BowlingGame = object
  rolls: seq[int]

proc newBowlingGame*(): BowlingGame =
  result = BowlingGame(rolls: @[])

proc roll*(this: var BowlingGame, pins: int) =
  # const outstr = "roll = "
  # echo outstr, pins
  this.rolls.add(pins)

proc is_strike(this: BowlingGame, frame_index: int): bool =
  return (this.rolls[frame_index] == 10)

proc is_spare(this: BowlingGame, frame_index: int): bool =
  return ((this.rolls[frame_index] + this.rolls[frame_index + 1]) == 10)

proc strike_score(this: BowlingGame, frame_index: int): int =
  return 10 + this.rolls[frame_index+1] + this.rolls[frame_index+2]

proc spare_score(this: BowlingGame, frame_index: int): int =
  return 10 + this.rolls[frame_index+2]

proc score*(this: BowlingGame): int =
  let maxIndex = this.rolls.len
  var bg = this
  bg.rolls.add(0)
  bg.rolls.add(0)
  result = 0
  var frame_index = 0
  for frame in countup(1,10):
    if frame_index >= maxIndex:
      break
    if bg.is_strike(frame_index):
        result += bg.strike_score(frame_index)
        frame_index += 1
    elif bg.is_spare(frame_index):
        result += bg.spare_score(frame_index)
        frame_index += 2
    else:
        result += bg.rolls[frame_index] + bg.rolls[frame_index + 1]
        frame_index += 2

