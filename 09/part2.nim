import std/strformat
import std/strutils
import std/sequtils

var
  sum: int = 0
  disk: seq[int]
  highest_id: int

for l in "../input/09/input.txt".lines:
  for i, c in l.pairs:
    let n = parseInt($c)
    var x: int

    if i %% 2 == 0:
      highest_id = i div 2
      x = highest_id
    else:
      x = -1

    for s in 0..<n:
      disk.add(x)

var lastindex: int = 0

for file_id in countdown(highest_id,1):
  let gap_needed: int = disk.count(file_id)

  for i in 0..disk.high:
    if disk[i] == file_id:
      lastindex = i
      break

  for i in 0..lastindex:
    let v: int = disk[i]
    if v > -1 : continue

    let file_end = i + gap_needed - 1
    if file_end > disk.high:
      break

    var diskfree: bool = true

    for b in i..file_end:
      if disk[b] >= 0:
        diskfree = false
        break

    if diskfree:
      # swap entire block
      for p1 in i..file_end:
        var p2 = lastindex + (p1 - i)
        (disk[p1], disk[p2]) = (disk[p2], disk[p1])
      break

for i, x in disk.pairs:
  if x > 0: sum += i * x

echo &"{sum}"
