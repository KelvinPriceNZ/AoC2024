import std/strformat
import std/tables
import std/deques

type
  coords = (int,int)

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

func perimeter(field: seq[coords]): int =
  result = 4 * field.len

  if field.len > 1:
    # For every pair ...
    for c1 in 0..<field.high:
      for c2 in c1 + 1..field.high:
        var diff = field[c2] - field[c1]

        # Remove 2 edges if they are beside each other
        if diff == (1,0): result -= 2
        if diff == (0,1): result -= 2
        if diff == (0,-1): result -= 2
        if diff == (-1,0): result -= 2


for l in "../input/12/input.txt".lines:
  grid.add(@[])
  for c in l:
    grid[^1].add(c)

let height = grid.len
let width = grid[0].len

var regions: seq[seq[coords]]
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
