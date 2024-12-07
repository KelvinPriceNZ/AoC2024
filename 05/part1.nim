
import strutils
import std/strformat
import nre
import std/algorithm

var
  sum: int = 0
  rules: seq[(int,int)]


proc check(r: seq[(int,int)], o: seq[int]): bool =
  for a in 0..o.high - 1:
    for b in a + 1..o.high:
      if (o[b], o[a]) in r:
        return false

  result = true

proc ord_cmp(a, b: int): int =
  if (a,b) in rules:
    return -1
  if (b,a) in rules:
    return 1
  return 0



for l in "../input/05/input.txt".lines:
  if l.contains(re"\|"):
    let XY = l.split("|")
    let X = parseInt(XY[0])
    let Y = parseInt(XY[1])
    rules.add((X,Y))

  if l.contains(re","):
    var order: seq[int]
    for n in l.split(","):
      order.add(parseInt(n))

    if order == order.sorted(ord_cmp):
      sum += order[order.len div 2]

echo &"{sum}"
