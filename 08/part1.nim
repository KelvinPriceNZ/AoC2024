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

func `-`(a,b: coords): coords =
  return (a[0]-b[0], a[1]-b[1])

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
  for i, c1 in v[0..^2].pairs:
    for c2 in v[i+1..^1]:
      let dir: coords = c1 - c2

      let a1 = c1 + dir
      let a2 = c2 - dir

      antinodes.incl(a1)
      antinodes.incl(a2)

for c in antinodes:
  if inbounds(c, height, width):
    sum += 1

echo &"{sum}"
