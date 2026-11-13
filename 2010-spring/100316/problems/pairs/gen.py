#! /usr/bin/python
TASKNAME = 'pairs'
TESTSTR = '%d'
SMALLTESTS = 2
TOFILES = False

import random, sys
random.seed (hash (TASKNAME))
try:
  import psyco
  psyco.full ()
  sys.stderr.write ('(using psyco)\n')
except:
  sys.stderr.write ('(psyco not available)\n')

MinN, MaxN = 1, 5000
MinA, MaxA = 1, 10 ** 9
MinB, MaxB = 1, 10 ** 9

test = SMALLTESTS

def out (a):
  global test
  test += 1
  sys.stderr.write ('Test ' + TESTSTR % test + '\n')
  n = len (a)
  assert MinN <= n <= MaxN
  for i in range (n):
    assert MinA <= a[i][0] <= MaxA
    assert MinB <= a[i][1] <= MaxB
  if TOFILES:
    f = open (TESTSTR % test, 'wt')
  else:
    f = sys.stdout
  f.write ('\n%d\n' % n)
  for i in range (n):
    f.write ('%d %d\n' % a[i])
  if TOFILES:
    f.close ()

def genrandom (n, lo, hi):
  a = []
  for i in range (n):
    a.append ((random.randint (lo, hi),
     random.randint (lo, hi)))
  return a

def genrandom2 (n, lo1, hi1, lo2, hi2):
  a = []
  for i in range (n):
    a.append ((random.randint (lo1, hi1),
     random.randint (lo2, hi2)))
  return a

# Small tests
for x in [[1, 2, 3], [2, 1, 3], [2, 3, 1], [3, 2, 1]]:
  for a in [1, 6]:
    for b in [2, 5]:
      for c in [3, 4]:
        out (zip (x, [a, b, c]))

out (genrandom (4, 1, 10))
out (genrandom (5, 2, 20))
out (genrandom (6, 3, 5))
out (genrandom (7, 6, 7))
out (genrandom (10, 100, 110))

# Medium tests
for n in [100, 200, 500, 1000]:
  out (genrandom (n, MinA, MinA + 10))
  out (genrandom (random.randint (n / 2, n), MinA, MaxA))
  out (genrandom (n, MinA, MaxA))
  out (genrandom (n / 2, MaxA / 2 + 1, MaxA) +
   genrandom (n / 2, MinA, MaxA / 2))
  out (genrandom2 (n / 2, MaxA / 2 + 1, MaxA, MinB, MaxB) +
   genrandom2 (n / 2, MinA, MaxA / 2, MinB, MaxB))
  out (genrandom (n, MaxA - 10, MaxA))

# Large tests
for n in [2000, 3333, 5000]:
  out (genrandom (n, MinA, MinA + 10))
  out (genrandom (random.randint (n / 2, n), MinA, MaxA))
  out (genrandom (n, MinA, MaxA))
  out (genrandom (n / 2, MaxA / 2 + 1, MaxA) +
   genrandom (n / 2, MinA, MaxA / 2))
  out (genrandom2 (n / 2, MaxA / 2 + 1, MaxA, MinB, MaxB) +
   genrandom2 (n / 2, MinA, MaxA / 2, MinB, MaxB))
  out (genrandom (n, MaxA - 10, MaxA))

a = range (MinA, MinA + MaxN)
b = range (MinA, MinA + MaxN)
for x in [a, a[::-1], b, b[::-1]]:
  for y in [a, a[::-1], b, b[::-1]]:
    out (zip (x, y))
out (genrandom2 (MaxN, MaxA - 1, MaxA, MinB, MaxB))
out (genrandom2 (MaxN, MaxA, MaxA, MinB, MaxB))
