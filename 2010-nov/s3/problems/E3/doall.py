from subprocess import call
import os
import shutil

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

# Solution
def sol(N): 
  E=0
  AA=0
  A=0
  B=1
  All=1
  for i in range(N):
    E,AA,A,B = E*2+AA, A, B, AA+A+B
    All *= 2
  return E

print 'Generate tests: ',
test = 1
for i in (1,2,5,11,23,26,30,29,28,27):
  print test,
  InFileName = "%02d" % test
  f = open(InFileName, 'w')
  f.write("%s\n" % i)
  f.close()
  OutFileName = "%02d.a" % test
  f = open(OutFileName, 'w')
  f.write("%d\n" % sol(i))
  f.close()
  test += 1

print 'done'

# Check all 
call('run.exe')