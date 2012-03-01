#! /usr/bin/python
TASKNAME = 'permut'
TESTSTR = '%d'
SMALLTESTS = 11
TOFILES = False

import random, sys
random.seed (hash (TASKNAME))
try:
  import psyco
  psyco.full ()
  sys.stderr.write ('(using psyco)\n')
except:
  sys.stderr.write ('(psyco not available)\n')

MinN, MaxN = 1, 1000000

test = SMALLTESTS

def out (a):
  global test
  test += 1
  sys.stderr.write ('Test ' + TESTSTR % test + '\n')
  n = len (a)
  assert MinN <= n <= MaxN
  b = [False] * n
  for i in range (n):
    assert MinN <= a[i] + 1 <= MaxN
    assert not b[a[i]]
    b[a[i]] = True
  if TOFILES:
    f = open (TESTSTR % test, 'wt')
  else:
    f = sys.stdout
  f.write ('\n%d\n' % n)
  s = ''
  for i in range (n):
    s += '%d ' % (a[i] + 1)
  f.write ('%s\n' % s[:-1])
  if TOFILES:
    f.close ()

def genrandom (n):
  a = range (n)
  random.shuffle (a)
  return a

def genalmostsorted (n, p):
  a = range (n)
  for i in range (p):
    x = random.randrange (n)
    y = random.randrange (n)
    a[x], a[y] = a[y], a[x]
  return a

def genalmostsorted2 (n, p):
  a = range (n)
  for i in range (p):
    x = random.randrange (n - 1)
    y = x + 1
    a[x], a[y] = a[y], a[x]
  return a

# Small tests
for n in [10, 15, 20, 23, 50]:
  out (genrandom (n))
  out (genalmostsorted (n, n / 3))
  out (genalmostsorted (n, n / 4) [::-1])

# Medium tests
for n in [100, 200, 500, 1000, 2000, 5000]:
  out (genrandom (n))
  out (genalmostsorted (n, n / 3))
  out (genalmostsorted (n, n / 4) [::-1])

# Large tests
for n in [10000, 20000, 50000, 100000, 200000, 500000, 1000000]:
  out (genrandom (n))
  out (genalmostsorted (n, n / 3))
  out (genalmostsorted (n, n / 4) [::-1])

out (genalmostsorted (MaxN, 0))
out (genalmostsorted (MaxN, 0) [::-1])
out (genalmostsorted (MaxN, 1))
out (genalmostsorted (MaxN, 1) [::-1])
out (genalmostsorted2 (MaxN, MaxN))
out (genalmostsorted2 (MaxN, MaxN) [::-1])
