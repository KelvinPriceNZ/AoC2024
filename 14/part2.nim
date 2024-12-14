import std/strformat
import std/strscans
import std/terminal

type
  coords = (int,int)
  robot = object
    pos: coords
    vel: coords

var
  sum: int = 0

let height = 103
let width = 101

var grid: seq[seq[char]]

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

for r in 0..<height:
  grid.add(@[])
  for c in 0..<width:
    grid[^1].add(' ')

var s: int = 0
while true:
  s += 1
  for r in 0..robots.high:
    robots[r].step()

  # 63 and 82 learned from observing 1s increments and noticing a pattern
  if s %% 103 == 63 and s %% 101 == 82:
    for r in 0..<height:
      for c in 0..<width:
        grid[r][c] = ' '
    for r in 0..robots.high:
      var x, y: int
      (x,y) = robots[r].pos
      grid[x][y] = '*'
    for r in 0..<height:
      for c in 0..<width:
        write(stdout, grid[r][c])
      write(stdout, "\n")
    flushFile(stdout)
    echo &"{s:15} seconds"
    #[
    # Wait for a key press every loop
    var k: char = getch()
    if k == 'q':
      break
    ]#
    break

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
