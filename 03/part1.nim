import std/strutils
import std/strformat
import std/nre

var
  sum: int = 0


for l in "../input/03/input.txt".lines:
  let patt = re(r"mul\(\d{1,3},\d{1,3}\)")
  let num = re(r"\d{1,3}")

  for c in findAll(l, patt):
    var x: int = 1
    for n in findAll(c, num):
      x *= parseInt(n)
    
    sum += x


echo &"{sum}"
