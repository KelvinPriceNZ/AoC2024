import std/strformat
import std/tables
import std/sets

var
  sum: int
  grid: seq[seq[char]]
  locks, keys: seq[seq[int]]


for l in "../input/25/input.txt".lines:
  if l.len == 0: continue

  if grid.len < 6:
    grid.add(@[])
    for c in l:
      grid[^1].add(c)
  else:
    var counts: seq[int] = newSeq[int](5)
    for i in 0..4:
      counts[i] = 0

    for h in 0..grid.high:
      for w in 0..grid[0].high:
        if grid[h][w] == '#':
          counts[w] += 1

    if '#' in grid[0]:
      locks.add(counts)
    else:
      keys.add(counts)

    grid = @[]

for lock in locks:
  for key in keys:
    var fits: bool = true

    for tumbler in 0..4:
      if lock[tumbler] + key[tumbler] > 6:
        fits = false
        break

    if fits:
      sum += 1

echo sum
