import std/strformat
import std/strutils

var
  sum: int = 0
  disk: seq[int]

for l in "../input/09/input.txt".lines:
  for i, c in l.pairs:
    let n = parseInt($c)

    if i %% 2 == 0:
      let file_id = i div 2
      for s in 0..<n:
        disk.add(file_id)
    else:
      for s in 0..<n:
        disk.add(-1)

var l: int = 0
var r: int = disk.high

while l < r:
  while disk[l] >= 0: l += 1
  while disk[r] < 0: r -= 1

  if l < r:
    (disk[l], disk[r]) = (disk[r], disk[l])

for i, x in disk:
  if x > 0: sum += i * x

echo &"{sum}"
