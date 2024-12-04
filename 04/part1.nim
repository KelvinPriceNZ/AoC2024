import std/strformat
import sequtils

var
  sum: int = 0
  grid: seq[seq[char]]


let neighbours = @[(0,1),(1,1),(1,0),(1,-1),(0,-1),(-1,-1),(-1,0),(-1,1)]


var data = "../input/04/input.txt".lines.toSeq

for row, line in data.pairs:
  grid.add(@[])
  for c in line:
    grid[row].add(c)

let height = grid.len
let width = grid[0].len

proc check(row, col: int, dir: (int,int), ch: char): bool =
  let x = row + dir[0]
  let y = col + dir[1]

  if x < 0 or x >= height:
    return false
  if y < 0 or y >= width:
    return false
  if grid[x][y] == ch:
    return true

  return false


for r in 0..<height:
  for c in 0..<width:
    if grid[r][c] == 'X':
      for n in neighbours:
        if check(r,c,n,'M'):
          let mr = r + n[0]
          let mc = c + n[1]
          if check(mr,mc,n,'A'):
            let ar = mr + n[0]
            let ac = mc + n[1]
            if check(ar,ac,n,'S'):
              sum += 1

echo &"{sum}"
