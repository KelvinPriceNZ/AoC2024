import std/strformat
import std/tables
import std/strscans
import math

type
  coords = (int64,int64)


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
  sum: int64 = 0
  BtnA, BtnB, Prize: coords
  X, Y: int
  fees = {'A': 3, 'B': 1}.toTable


proc cost(a, b, p: coords): int64 =
  # get the intersection point of the 2 lines
  let x1 = a[0]
  let y1 = a[1]
  let x2 = b[0]
  let y2 = b[1]
  let c1 = p[0]
  let c2 = p[1]

  # Got the formulas from Uncle Google
  let X = (c1 * y2 - c2 * x2) div (x1 * y2 - y1 * x2)
  let Y = (c1 - X * x1) div x2

  if X * x1 + Y * x2 == c1 and X * y1 + Y * y2 == c2:
    return X * fees['A'] + Y * fees['B']
  
  return -1
  

for l in "../input/13/input.txt".lines:
  if scanf(l, "Button A: X+$i, Y+$i", X, Y):
    BtnA=(X.int64,Y.int64)
  if scanf(l, "Button B: X+$i, Y+$i", X, Y):
    BtnB=(X.int64,Y.int64)
  if scanf(l, "Prize: X=$i, Y=$i", X, Y):
    Prize=(X.int64 + 10000000000000,Y.int64 + 10000000000000)

    let bill = cost(BtnA, BtnB, Prize)
    if bill > 0:
      sum += bill

echo &"{sum}"
