import os

def R(f,t): return xrange(f,t+1)

t = 1
n = '%02d' % t
while os.path.isfile(n):
  f = open(n,'r')
  print '('+f.readline().strip()+'),',
  f.close()
  t += 1
  n = '%02d' % t
