import std/strformat
import std/tables
import std/sets

type
  coords = (int,int)

var
  sum: int = 0
  grid: seq[seq[char]]


func `+`(a,b: coords): coords =
  return (a[0]+b[0], a[1]+b[1])

func `+=`(a: var coords, b: coords): coords {.discardable.} =
  a = a + b
  discard

func `-`(a,b: coords): coords =
  return (a[0]-b[0], a[1]-b[1])

func `-=`(a: var coords, b: coords): coords {.discardable.} =
  a = a - b
  discard

func `==`(a,b: coords): bool =
  return a[0] == b[0] and a[1] == b[1]

func inbounds(c: coords, h,w: int): bool =
  return c[0] >= 0 and c[0] < h and c[1] >= 0 and c[1] < w


for l in "../input/08/input.txt".lines:
  grid.add(@[])
  for c in l:
    grid[^1].add(c)

let height = grid.len
let width = grid[0].len

var antennas: Table[char, seq[coords]]
var antinodes: HashSet[coords]

for r in 0..<height:
  for c in 0..<width:
    let cell: char = grid[r][c]
    if cell != '.':
      if not (cell in antennas):
        antennas[cell] = @[]
      antennas[cell].add((r,c))

for k, v in antennas:
  # For every pair of matched antennas
  for i, c1 in v[0..^2].pairs:
    for c2 in v[i+1..^1]:
      antinodes.incl(c1)
      antinodes.incl(c2)

      var dir: coords = c1 - c2

      #[
        While the dir values are even we can
        continuously halve them to get the
        the positions half-way between them
        and also extend in each direction
      ]#

      while dir[0] %% 2 == 0 and dir[1] %% 2 == 0:
        dir[0] = dir[0] div 2
        dir[1] = dir[1] div 2

      var a1 = c1 + dir
      var a2 = c2 - dir

      # Extend in each direction
      while inbounds(a1, height, width):
        antinodes.incl(a1)
        a1 += dir

      while inbounds(a2, height, width):
        antinodes.incl(a2)
        a2 -= dir

for c in antinodes:
  if inbounds(c, height, width):
    sum += 1

echo &"{sum}"
