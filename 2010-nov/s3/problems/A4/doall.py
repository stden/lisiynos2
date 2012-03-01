from subprocess import call
import os
import shutil
import random
random.seed (12439)

def compile(filename):
  ext = os.path.splitext(filename)[1]
  if ext == '.dpr' or ext == '.pas':
    call('dcc32 '+filename)
  elif ext == '.cpp':
    call('cpp '+filename)

if not os.path.isfile('testlib.pas'):
  shutil.copyfile('../../../testlib/testlib.pas','testlib.pas')
compile('check.dpr')

compile('solution.dpr')

import os
TaskID = os.path.split(os.path.dirname( __file__ ))[1]
print 'Create "task.cfg" for "%s"' % TaskID
f = open("task.cfg", 'w')
f.write('InputFile := %s.in;\n' % TaskID)
f.write('OutputFile := %s.out;\n' % TaskID)
f.write('CheckResult := true;\n')
f.close()

# Random number in range low..high
def rand(low,high):
  return low+random.randrange(high-low+1)

print 'Generate tests: ',
test = 2
for i in ((4,2), (5,4), (6,6), (8,6), (10,7), (15,9), (16,7), (16,8), (16,9), (16,10)):
  print test,
  InFileName = "%02d" % test
  f = open(InFileName, 'w')
  N, M, S = (i[0],i[1], 1+random.randrange(i[0]))
  f.write("%d %d %d\n" % (N,M,S))
  for j in range(M):
    f.write("%d %d\n" % (rand(1,N),rand(1,N)))
  f.close()
  # Next test :)
  test += 1

print 'done'

# Check all 
call('run.exe')