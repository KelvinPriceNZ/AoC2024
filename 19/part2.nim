import std/strformat
import std/sequtils
import std/strutils
import std/algorithm
import memo

var
  sum: int = 0


proc dfs(target: string, guess: string, clrs: seq[string]): int {.memoized.} =
  if guess.len > target.len:
    return 0

  if guess == target:
    return 1

  var total: int = 0

  for clr in clrs:
    var new_guess = clr & guess
    var num: int = 0

    if target.endsWith(new_guess):
      num = dfs(target, new_guess, clrs)

      if num > 0:
        total += num
        #break

  return total


var colours: seq[string]
var patterns: seq[string]

for i, l in "../input/19/input.txt".lines.toSeq.pairs():
  if i == 0:
    colours = l.split(", ")
    colours.sort
    colours.reverse

  if i > 1:
    patterns.add(l)

for pattern in patterns:
  sum += dfs(pattern, "", colours)

echo &"{sum}"
