import std/strformat
import sequtils

type
  coords = (int,int)

var
  sum: int = 0
  grid: seq[seq[char]]

func `+`(a,b: coords): coords =
  result = (a[0]+b[0], a[1]+b[1])


var data = "../input/06/input.txt".lines.toSeq

for row, line in data.pairs:
  grid.add(@[])
  for c in line:
    grid[row].add(c)

let height = grid.len
let width = grid[0].len

var guard: coords = (-1,-1)

# Find the guard's starting coords
for r in 0..<height:
  for c in 0..<width:
    if grid[r][c] == '^':
      guard = (r,c)
      break
  if guard != (-1,-1):
    break

var dir: (int,int) = (-1,0)

while guard[0] >= 0 and guard[1] >= 0 and guard[0] < height and guard[1] < width:
  let newpos: coords = guard + dir

  if not (newpos[0] >= 0 and newpos[1] >= 0 and newpos[0] < height and newpos[1] < width):
    break

  let next: char = grid[newpos[0]][newpos[1]]

  if next != '#':
    guard = newpos
    if next == '.':
      sum += 1
      grid[newpos[0]][newpos[1]] = 'X'
  else:
    if dir == (-1,0):
      dir = (0,1)
    elif dir == (0,1):
      dir = (1,0)
    elif dir == (1,0):
      dir = (0,-1)
    elif dir == (0,-1):
      dir = (-1,0)

# add in the guarding cell
sum += 1

echo &"{sum}"
