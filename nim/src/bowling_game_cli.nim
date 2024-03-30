import os

proc calcBowlingScore(filename: string) =
  var
    file: File
    line: string

  file = open(filename)
  if file == nil:
    quit(1)

  while not file.endOfFile:
    line = file.readLine()
    if line.len > 0:
      echo line

  file.close()

when isMainModule:
  # echo paramCount()
  if paramCount() != 1:
    # echo "paramCount() != 1"
    quit(1)
  # echo "paramCount() == 1"
  let filename = paramStr(1)
  # echo filename
  calcBowlingScore(filename)

