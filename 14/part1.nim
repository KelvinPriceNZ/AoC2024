import std/strformat
import std/strscans

type
  coords = (int,int)
  robot = object
    pos: coords
    vel: coords

var
  sum: int = 0

let height = 103
let width = 101


func `+`(a,b: coords): coords =
  return (a[0]+b[0], a[1]+b[1])

method transport(self: var robot): int {.discardable,base.} =
  if self.pos[0] < 0: self.pos[0] = self.pos[0] + height
  if self.pos[0] >= height: self.pos[0] = self.pos[0] - height
  if self.pos[1] < 0: self.pos[1] = self.pos[1] + width
  if self.pos[1] >= width: self.pos[1] = self.pos[1] - width

method step(self: var robot): int {.discardable,base.} =
  self.pos = self.pos + self.vel
  self.transport()


var px, py, vx, vy: int

var robots: seq[robot]

for l in "../input/14/input.txt".lines:
  if l.scanf("p=$i,$i v=$i,$i", px, py, vx, vy):
    robots.add(robot(pos: (py, px), vel:(vy, vx)))

for _ in 1..100:
  for r in 0..robots.high:
    robots[r].step()

let hc = height div 2
let wc = width div 2

var tl, tr, bl, br: int = 0

for robot in robots:
  let rh = robot.pos[0]
  let rw = robot.pos[1]

  if rh == hc: continue
  if rw == wc: continue

  if rh < hc and rw < wc: tl += 1
  if rh < hc and rw > wc: tr += 1
  if rh > hc and rw < wc: bl += 1
  if rh > hc and rw > wc: br += 1

sum = tl * tr * bl * br

echo &"{sum}"
