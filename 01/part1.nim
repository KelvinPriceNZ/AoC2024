import strutils
import std/strformat
import std/algorithm

var sum: int = 0

var
  left, right: seq[int]

for l in "../input/01/input.txt".lines:
  let words = l.split(' ')
  var num1 = words[0].parseInt
  var num2 = words[^1].parseInt
  left.add(num1)
  right.add(num2)

left.sort
right.sort

for n in 0..<left.len:
  sum += abs(left[n] - right[n])

echo &"{sum}"
