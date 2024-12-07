import strutils
import std/strformat
import sequtils

var
  sum: int = 0


proc calc(soln: int, answer: var int, terms: seq[int], candidates: var seq[int], depth: int): int {.discardable.} =
  if depth == terms.high:
    if answer == soln:
      candidates.add(answer)
  else:
    for op in ['+','*','&']:
      var curr: int = answer
      case op:
        of '+':
          answer += terms[depth + 1]
        of '*':
          answer *= terms[depth + 1]
        of '&':
          answer = parseInt($answer & $terms[depth + 1])
        else:
          discard

      if answer <= soln:
        calc(soln, answer, terms, candidates, depth + 1)

      answer = curr


for l in "../input/07/input.txt".lines:
  var termlist: string
  let words = l.split(':')
  var solution: int = words[0].parseInt
  termlist = words[1]
  var terms: seq[int] = termlist.splitWhitespace.toSeq.mapIt(parseInt(it))

  var choices: seq[int]

  calc(solution, terms[0], terms, choices, 0)
  for ans in choices:
    if ans == solution:
      sum += solution
      break

echo &"{sum}"
