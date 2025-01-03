import strutils
import std/strformat
import std/algorithm

var
  sum: int = 0


func ok(s: seq): bool =
  if s == s.sorted or s == s.sorted.reversed:
    var
      f: bool = true

    for i in 1..s.high:
      let d = abs(s[i] - s[i - 1])
      if d < 1 or d > 3:
        f = false
        break

    if f:
      return true

  return false


for l in "../input/02/input.txt".lines:
  let nums = l.splitWhitespace

  var a: seq[int]

  for n in nums:
    a.add(parseInt(n))

  if ok(a):
    sum += 1

echo &"{sum}"
