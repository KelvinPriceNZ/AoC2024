import strutils
import std/strformat
import std/algorithm

var
  sum: int = 0


func ok(s: seq): bool =
  var asc = s
  var dsc = s

  asc.sort
  dsc.sort(order=SortOrder.Descending)

  if s == asc or s == dsc:
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
  else:
    var f: bool = false

    for i in 0..a.high:
      var x = a
      x.delete(i)

      if ok(x):
        f = true
        break

    if f:
      sum += 1

echo &"{sum}"
