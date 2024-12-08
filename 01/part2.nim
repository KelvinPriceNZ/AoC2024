import strutils
import std/strformat
import sequtils

var
  sum: int = 0
  left, right: seq[int]


for l in "../input/01/input.txt".lines:
  let words = l.splitWhitespace
  var num1 = words[0].parseInt
  var num2 = words[1].parseInt
  left.add(num1)
  right.add(num2)

for n in 0..<left.len():
  sum += left[n] * right.count(left[n])

echo &"{sum}"
