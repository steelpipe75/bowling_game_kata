type BowlingGame = object
  rolls: seq[int]

proc newBowlingGame*(): BowlingGame =
  result = BowlingGame(rolls: @[])

proc roll*(this: var BowlingGame, pins: int) =
  # const outstr = "roll = "
  # echo outstr, pins
  this.rolls.add(pins)

proc score*(this: BowlingGame): int =
  for i, roll in this.rolls:
    echo i, " ", roll
  result = 0
