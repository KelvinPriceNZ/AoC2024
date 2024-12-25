#!/usr/bin/env python3.12

import networkx as nx

grid = nx.Graph()

with open("../input/23/input.txt", "r") as f:
   data = [l.strip() for l in f.read().splitlines()]

for edge in data:
   left, right = edge.split("-")

   grid.add_edge(left, right)
   grid.add_edge(right, left)

max = 0

for clique in nx.find_cliques_recursive(grid):
   l = len(clique)
   if l > max:
      max = l
      print(f"{l:2} | {",".join(sorted(clique))}")
