import std/strutils
import std/sequtils
import math
import std/tables

var
  stones: seq[int]
  memo: Table[(int, int), int]


proc blink(stone: int): seq[int] =
  if stone == 0:
    return @[1]

  if ($stone).len %% 2 == 0:
    let power: int =  10 ^ (($stone).len div 2)
    var left = stone div power
    var right = stone %%  power
    return @[left, right]
  else:
    return @[stone * 2024]


proc dfs(stone, depth: int): int =
  if depth == 0:
    return 1

  if (stone, depth) in memo:
    return memo[(stone, depth)]

  var count: int = 0

  var blinked = blink(stone)

  for b in blinked:
    count += dfs(b, depth - 1)

  memo[(stone, depth)] = count

  return count
  

func sum(s: seq[int]): int =
  result = s.foldl(a + b)


for l in "../input/11/input.txt".lines:
  stones = l.splitWhitespace.map(parseInt).toSeq

echo stones.map(proc(x:int): int = dfs(x, 75)).sum
