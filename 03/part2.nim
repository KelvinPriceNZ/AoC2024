import std/strutils
import std/strformat
import std/nre

var
  sum: int = 0


var enabled: bool = true

for l in "../input/03/input.txt".lines:
  let patt = re(r"(do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\))")
  let num = re(r"\d{1,3}")

  for c in findAll(l, patt):
    if c.contains(re"^do\("):
      enabled = true
    if c.contains(re"^don't\("):
      enabled = false
    if enabled:
      if c.contains(re"^mul"):
        var x: int = 1
        for n in findAll(c, num):
          x *= parseInt(n)

        sum += x
    
echo &"{sum}"
