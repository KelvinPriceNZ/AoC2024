import std/strformat
import std/sequtils
import std/strutils
import std/algorithm
import std/times

var
  sum: int = 0


proc dfs(target: string, guess: string, clrs: seq[string]): bool =
  if guess.len > target.len:
    return false

  if guess == target:
    return true

  var found: bool = false

  for clr in clrs:
    var new_guess = clr & guess

    if target.endsWith(new_guess):
      if dfs(target, new_guess, clrs):
        found = true
        break

  return found


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
  if dfs(pattern, "", colours):
    sum += 1

echo &"{sum}"

# Functional Programming ?
#echo patterns.mapIt(dfs(it, "", colours)).filterIt(it).mapIt(1).foldl(a + b)
