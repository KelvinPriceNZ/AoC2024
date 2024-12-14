import std/strformat
import std/tables
import std/strscans
import std/sequtils
import math

type
  coords = (int,int)


func `+`(a,b: coords): coords = (a[0] + b[0], a[1] + b[1])

func `-`(a,b: coords): coords = (a[0] - b[0], a[1] - b[1])

func `*`(a,b: coords): coords = (a[0] * b[0], a[1] * b[1])

func `<`(a,b: coords): bool = a[0] < b[0] and a[1] < b[1]
func `<=`(a,b: coords): bool = a[0] <= b[0] and a[1] <= b[1]
func `>`(a,b: coords): bool = a[0] > b[0] and a[1] > b[1]
func `>=`(a,b: coords): bool = a[0] >= b[0] and a[1] >= b[1]
func `==`(a,b: coords): bool = a[0] == b[0] and a[1] == b[1]
func `!=`(a,b: coords): bool = not (a == b)


var
  sum: int = 0
  BtnA, BtnB, Prize: coords
  X, Y: int
  fees = {'A': 3, 'B': 1}.toTable


iterator factors(a,b, target: int): (int, int) =
  let g: int = gcd(a,b)

  let a1 = a div g
  let b1 = b div g
  let t1 = target div g

  if a1 > b1:
    var l = t1 div a1
    for x in 0..l:
      var y = (t1 - (a1 * x)) div b1
      if a1 * x + b1 * y == t1:
        yield (x,y)
  else:
    var l = t1 div b1
    for y in 0..l:
      var x = (t1 - (b1 * y)) div a1
      if a1 * x + b1 * y == t1:
        yield (x,y)


proc cost(a, b, p: coords): int =
  var m, c: int = (2 ^ 62)

  var f1 = factors(a[0],b[0],p[0]).toSeq
  var f2 = factors(a[1],b[1],p[1]).toSeq

  for f in f1:
    if f in f2:
      c = f[0] * fees['A'] + f[1] * fees['B']

      if c < m: m = c

  if m < (2 ^ 62):
    return m
  
  return -1


for l in "../input/13/input.txt".lines:
  if scanf(l, "Button A: X+$i, Y+$i", X, Y):
    BtnA=(X,Y)
  if scanf(l, "Button B: X+$i, Y+$i", X, Y):
    BtnB=(X,Y)
  if scanf(l, "Prize: X=$i, Y=$i", X, Y):
    Prize=(X,Y)

    let bill = cost(BtnA, BtnB, Prize)
    if bill > 0:
      sum += bill

echo &"{sum}"
