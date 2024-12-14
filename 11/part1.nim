
import std/strformat
import std/strutils
import std/sequtils
import math

var
  sum: int = 0
  stones: seq[int]


for l in "../input/11/input.txt".lines:
  stones = l.splitWhitespace.map(parseInt)

for blinks in 1..25:
  var new_stones: seq[int]

  for stone in stones:
    if stone == 0:
      new_stones.add(1)
      continue

    var scale: int = log10(stone.float).int  
    if scale %% 2 == 1:
      let power: int =  10 ^ ((scale div 2) + 1)
      var left = stone div power
      var right = stone %%  power
      new_stones.add(left)
      new_stones.add(right)
    else:
      new_stones.add(stone * 2024)

  stones = new_stones

sum += stones.len

echo &"{sum}"
