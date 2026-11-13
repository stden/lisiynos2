from subprocess import call
import os
import shutil

def compile(filename):
  ext = os.path.splitext(filename)[1]
  if ext == '.dpr':
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
def fib(n):
  a, b = 0, 1
  for i in range(n):
    a, b = b, a+b
  return a

print 'Generate tests: ',
test = 1
for i in (1,2,6,70,99,3,4,5,6,70,33,43,45,62,64,78,81,102,223,356,458,999):
  print test,
  InFileName = "%02d" % test
  f = open(InFileName, 'w')
  f.write("%s\n" % i)
  f.close()
  OutFileName = "%02d.a" % test
  f = open(OutFileName, 'w')
  f.write("%d\n" % fib(i))
  f.close()
  test += 1
print 'done'

# Check all 
call('run.exe')