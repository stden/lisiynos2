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
def sol(N,K): 
  TZ=0; Z=0; NZ=K-1
  for i in range(2,N+1):
    TZ,Z,NZ = TZ*K+Z, NZ, Z*(K-1)+NZ*(K-1)
  return Z+NZ

print 'Generate tests: ',
test = 1
for i in ((4,3), (5,2), (5,5), (5,5), (8,6), (8,9), (8,10)):
  print test,
  InFileName = "%02d" % test
  f = open(InFileName, 'w')
  f.write("%d %d\n" % (i[0],i[1]))
  f.close()
  OutFileName = "%02d.a" % test
  f = open(OutFileName, 'w')
  f.write("%d\n" % sol(i[0],i[1]))
  f.close()
  test += 1

print 'done'

# Check all 
call('run.exe')