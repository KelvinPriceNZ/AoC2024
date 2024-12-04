import std/strformat
import sequtils

var
  sum: int = 0
  grid: seq[seq[char]]


var data = "../input/04/input.txt".lines.toSeq

for row, line in data.pairs:
  grid.add(@[])
  for c in line:
    grid[row].add(c)

let height = grid.len
let width = grid[0].len

for r in 1..<height - 1:
  for c in 1..<width - 1:
    if grid[r][c] == 'A':
      let tl = grid[r-1][c-1]
      let tr = grid[r-1][c+1]
      let bl = grid[r+1][c-1]
      let br = grid[r+1][c+1]

      if tl == 'M' and br == 'S':
        if tr == 'M' and bl == 'S':
          sum += 1
        if tr == 'S' and bl == 'M':
          sum += 1

      if tl == 'S' and br == 'M':
        if tr == 'M' and bl == 'S':
          sum += 1
        if tr == 'S' and bl == 'M':
          sum += 1


echo &"{sum}"
