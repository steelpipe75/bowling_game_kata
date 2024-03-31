import os
import strutils
import ./lib/bowling_game

proc calcBowlingScore(filename: string) =
  var
    file: File
    line: string
    pins: int
    bg = newBowlingGame()

  file = open(filename)
  if file == nil:
    quit(1)

  while not file.endOfFile:
    line = file.readLine()
    pins = parseInt(line)
    if pins >= 0:
      # echo line
      bg.roll(parseInt(line))

  file.close()
  echo bg.score()

when isMainModule:
  # echo paramCount()
  if paramCount() != 1:
    # echo "paramCount() != 1"
    quit(1)
  # echo "paramCount() == 1"
  let filename = paramStr(1)
  # echo filename
  calcBowlingScore(filename)

