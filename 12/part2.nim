import std/strformat
import std/tables
import std/deques

type
  coords = (int,int)
  seqCoords = seq[coords]

var
  sum: int = 0
  grid: seq[seq[char]]


func `+`(a,b: coords): coords =
  return (a[0]+b[0], a[1]+b[1])

func `-`(a,b: coords): coords =
  return (a[0] - b[0], a[1] - b[1])

func `==`(a,b: coords): bool =
  return a[0] == b[0] and a[1] == b[1]

func inbounds(c: coords, h,w: int): bool =
  return c[0] >= 0 and c[0] < h and c[1] >= 0 and c[1] < w

proc perimeter(field: seqCoords): int =
  # Part 2 discount, count edges, not 'fences' per cell
  let l = field.len

  if l <= 0: return 0
  if l == 1: return 4 # A single cell can only have 4 edges
  if l == 2: return 4 # A single pair of adjacent cells can only have 4 edges

  # 3+ cells, count edges (or corners)
  # Generate coords for all the cell corners
  var corners: seqCoords

  for f in field:
    corners.add(f)
    corners.add(f + (0,1))
    corners.add(f + (1,0))
    corners.add(f + (1,1))

  var v: Table[coords, int]

  # Count the number of times each corner occurs
  for c in corners:
    if v.contains(c):
      v[c] += 1
    else:
      v[c] = 1

  result = 0

  # Corners with odd counts matter
  for c in v.values:
    if c %% 2 == 1: result += 1

  #[

  Need to add back for diagonally touching corners

  e.g. XXXX XXXX
       XX X X XX
       X XX XX X
       XXXX XXXX

  ]#

  let height = grid.len
  let width = grid[0].len

  for c1 in 0..<l-1:
    for c2 in c1 + 1..<l:
      let f1 = field[c1]
      let f2 = field[c2]

      if not inbounds(f1, height, width): continue
      if not inbounds(f2, height, width): continue

      if f2 - f1 == (1,1):
        if f2 + (-1,0) in field or f2 + (0,-1) in field:
          continue
        else:
          result += 2
      if f2 - f1 == (-1,-1):
        if f2 + (1,0) in field or f2 + (0,1) in field:
          continue
        else:
          result += 2
      if f2 - f1 == (1,-1):
        if f2 + (-1,0) in field or f2 + (0,1) in field:
          continue
        else:
          result += 2
      if f2 - f1 == (-1,1):
        if f2 + (0,-1) in field or f2 + (1,0) in field:
          continue
        else:
          result += 2


for l in "../input/12/input.txt".lines:
  grid.add(@[])
  for c in l:
    grid[^1].add(c)

let height = grid.len
let width = grid[0].len

var regions: seq[seqCoords]
var counted: Table[coords, bool]

for r in 0..<height:
  for c in 0..<width:
    counted[(r,c)] = false

for r in 0..<height:
  for c in 0..<width:
    if counted[(r,c)]: continue

    var ch = grid[r][c]

    var region: seq[coords] = @[(r,c)]
    var q = region.toDeque

    while q.len > 0:
      var cell = q.popFirst
      counted[cell] = true

      for dir in [(1,0),(0,-1),(-1,0),(0,1)]:
        var n = cell + dir

        if not inbounds(n, height, width): continue
        if counted[n]: continue

        if grid[n[0]][n[1]] == ch:
          q.addLast(n)
          region.add(n)
          counted[n] = true

    regions.add(region)

for region in regions:
  var blocks = region.len
  var fence = perimeter(region)

  sum += blocks * fence

  #[
  # Show each plot
  for r in 0..<height:
    for c in 0..<width:
      if (r,c) in region:
        write(stdout, grid[r][c])
      else:
        write(stdout, ".")
    write(stdout, "\n")
  write(stdout, "\n")
  ]#

echo &"{sum}"
