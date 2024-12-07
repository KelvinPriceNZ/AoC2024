
import strutils
import std/strformat
import nre
import sequtils
#import std/algorithm

var
  sum: int = 0
  rules: seq[(int,int)]


proc check(r: seq[(int,int)], o: seq[int]): bool =
  for a in 0..o.high - 1:
    for b in a + 1..o.high:
      if (o[b], o[a]) in r:
        return false

  result = true


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

    if not check(rules, order):
      var neworder: seq[int]

      neworder.add(order[0])

      for i in 1..order.high:
        let num = order[i]

        var temporder: seq[int]

        for p in 0..neworder.high + 1:
          temporder = neworder
          temporder.insert(@[num], p)
          if check(rules, temporder):
            break

        neworder = temporder

      sum += neworder[order.len div 2]

echo &"{sum}"
