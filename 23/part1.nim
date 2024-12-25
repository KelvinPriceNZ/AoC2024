import std/strformat
import std/tables
import std/strutils
import std/algorithm
import times

var
  sum: int = 0
  network: Table[string, seq[string]]
  triplets: Table[string, int]

for l in "../input/23/input.txt".lines:
#for l in "./sample.txt".lines:
  var node1, node2: string

  let nodes = l.split("-")

  (node1,node2) = (nodes[0], nodes[1])

  if node1 notin network:
    network[node1] = @[]
  if node2 notin network:
    network[node2] = @[]

  network[node1].add(node2)
  network[node2].add(node1)

let start = cpuTime()

for node, edges in network:
  for edge in edges:
    if node == edge: continue

    for n in network[edge]:
      if n == edge: continue

      if node in network[n]:
        if node.startsWith("t") or edge.startsWith("t") or n.startsWith("t"):
          let k = @[node, edge, n].sorted.join(",")

          if k notin triplets:
            sum += 1

          triplets[k] = 1

echo &"{sum}"
echo cpuTime() - start
