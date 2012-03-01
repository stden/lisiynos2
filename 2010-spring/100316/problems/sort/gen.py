#! /usr/bin/python
TASKNAME = 'sort'
TESTSTR = '%d'
SMALLTESTS = 20
TOFILES = False

import random, sys
random.seed (hash (TASKNAME))
try:
  import psyco
  psyco.full ()
  sys.stderr.write ('(using psyco)\n')
except:
  sys.stderr.write ('(psyco not available)\n')

MinN, MaxN = 1, 300000
MinA, MaxA = 1, 1000

test = SMALLTESTS

def out (a):
  global test
  test += 1
  sys.stderr.write ('Test ' + TESTSTR % test + '\n')
  n = len (a)
  assert MinN <= n <= MaxN
  for i in range (n):
    assert MinA <= a[i] <= MaxA
  if TOFILES:
    f = open (TESTSTR % test, 'wt')
  else:
    f = sys.stdout
  f.write ('\n%d\n' % n)
  s = ''
  for i in range (n):
    s += '%d ' % a[i]
  f.write ('%s\n' % s[:-1])
  if TOFILES:
    f.close ()

def genrandom (n, lo, hi):
  a = []
  for i in range (n):
    a.append (random.randint (lo, hi))
  return a

# Small tests
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
  out (genrandom (n, MaxA - 10, MaxA))

# Large tests
for n in [2000, 5000, 10000, 20000, 50000, 100000, 300000]:
  out (genrandom (n, MinA, MinA + 10))
  out (genrandom (random.randint (n / 2, n), MinA, MaxA))
  out (genrandom (n, MinA, MaxA))
  out (genrandom (n / 2, MaxA / 2 + 1, MaxA) +
   genrandom (n / 2, MinA, MaxA / 2))
  out (genrandom (n, MaxA - 10, MaxA))

out (genrandom (MaxN, MaxA - 1, MaxA))
out (genrandom (MaxN, MaxA, MaxA))
