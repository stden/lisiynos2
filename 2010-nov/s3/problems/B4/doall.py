from subprocess import call
import os
import shutil
import random
random.seed (12439)


def compile(filename):
  ext = os.path.splitext(filename)[1]
  if ext == '.dpr':
    call('dcc32 '+filename)
  elif ext == '.cpp':
    call('cpp '+filename)

if not os.path.isfile('testlib.pas'):
  shutil.copyfile('../../../testlib/testlib.pas','testlib.pas')
compile('check.dpr')

# compile('solution.dpr')

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
test = 1
for N in (4,5,7,70,99,3,4,5,6,70,33,43,45,62,64,78,81,102,223,356,458,999):
  print test,
  InFileName = "%02d" % test
  OutFileName = "%02d.a" % test
  fi = open(InFileName, 'w')
  fo = open(OutFileName, 'w')
  fi.write("%s\n" % N)
  S = []
  for i in range(N):
    T = rand(1,test*test+1)
    if (S == []) or (rand(1,2)==1):
      fi.write("PUSH %d\n" % T)
      S.append(T)
      fo.write("%s\n" % S)
    else:
      fi.write("POP\n")
      E = S[len(S)-1]
      S = S[:-1]
      fo.write("%d %s\n" % (E,S))
  fo.close()
  fi.close()
  test += 1
print 'done'

# Check all 
call('run.exe')