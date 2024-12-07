import std/strformat
import std/sequtils

type
  coords = (int,int)

var
  grid: seq[seq[char]]

func `+`(a,b: coords): coords =
  result = (a[0]+b[0], a[1]+b[1])

func `==`(a,b: coords): bool =
  result = a[0] == b[0] and a[1] == b[1]


var data = "../input/06/input.txt".lines.toSeq

for row, line in data.pairs:
  grid.add(@[])
  for c in line:
    grid[row].add(c)

let height = grid.len
let width = grid[0].len

var guard: coords = (-1,-1)

for r in 0..<height:
  for c in 0..<width:
    if grid[r][c] == '^':
      guard = (r,c)
      break
  if guard != (-1,-1):
    break

var dir: (int,int) = (-1,0)
var pos = guard
var path: seq[coords]

while pos[0] >= 0 and pos[1] >= 0 and pos[0] < height and pos[1] < width:
  let newpos: coords = pos + dir

  if not (newpos[0] >= 0 and newpos[1] >= 0 and newpos[0] < height and newpos[1] < width):
    break

  let next: char = grid[newpos[0]][newpos[1]]

  if next != '#':
    pos = newpos
    if next == '.':
      grid[pos[0]][pos[1]] = 'X'
      path.add(newpos)
  else:
    if dir == (-1,0):
      dir = (0,1)
    elif dir == (0,1):
      dir = (1,0)
    elif dir == (1,0):
      dir = (0,-1)
    elif dir == (0,-1):
      dir = (-1,0)

var loops: int = 0

var original_grid = grid

#[
Try putting an obstacle in each step of the path
Then check if it created a loop by checking if
we hit the same obstacle from the same direction
]#
for step in path:
  grid = original_grid
  var r, c: int
  (r,c) = (step[0],step[1])
  let cell = grid[r][c]

  var pos = guard

  if cell == 'X':
    grid[r][c] = '#'
    var dir: (int,int) = (-1,0)
    var turns: seq[(coords,(int,int))]
    var found: bool = false

    while pos[0] >= 0 and pos[1] >= 0 and pos[0] < height and pos[1] < width and not found:
      let newpos: coords = pos + dir

      if not (newpos[0] >= 0 and newpos[1] >= 0 and newpos[0] < height and newpos[1] < width):
        break

      let next: char = grid[newpos[0]][newpos[1]]

      if next != '#':
        pos = newpos
      else:
        if not ((pos,dir) in turns):
          turns.add((pos,dir))
        else:
          found = true
          break

        if dir == (-1,0):
          dir = (0,1)
        elif dir == (0,1):
          dir = (1,0)
        elif dir == (1,0):
          dir = (0,-1)
        elif dir == (0,-1):
          dir = (-1,0)

    if found:
      loops += 1

echo &"{loops}"
