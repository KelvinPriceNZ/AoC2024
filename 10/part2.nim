import strutils
import std/strformat
import std/sequtils


var
  sum: int = 0
  grid: seq[seq[int]]

for i, l in "../input/10/input.txt".lines.toSeq.pairs:
  grid.add(@[])
  for c in l:
    grid[i].add(parseInt($c))

let height = grid.len
let width = grid[0].len

proc dfs(st: (int,int), paths: var seq[(int,int)], depth: int): int {.discardable.} =
  var row = st[0]
  var col = st[1]

  let curr = grid[row][col]

  if curr == 9:
    paths.add(st)
    return

  for n in [(0,1),(1,0),(0,-1),(-1,0)]:
    let nr = row + n[0]
    let nc = col + n[1]

    if nr < 0: continue
    if nr >= height: continue
    if nc < 0: continue
    if nc >= width: continue

    let next = grid[nr][nc]

    if next - curr == 1:
      dfs((nr,nc), paths, depth + 1)


for r in 0..<height:
  for c in 0..<width:
    if grid[r][c] == 0:
      var trailheads: seq[(int, int)]

      dfs((r,c), trailheads, 0)

      sum += trailheads.len

echo &"{sum}"
