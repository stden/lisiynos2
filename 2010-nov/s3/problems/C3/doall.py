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
def sol(n):
  d = [1, 2, 4]
  for i in range(3,n):
    d.append( d[i-1] + d[i-2] + d[i-3] )
  return d[n-1]

compile('matr_g.pas')
compile('d_make.pas')

print 'Generate tests: '
call('RUNME.BAT')

#test = 8
#for i in (1,4,74,39,1,3,13,17,22,25,34,40,37,73,39,40,50,51,60,999):
#  print test,
 # InFileName = "%02d" % test
#  f = open(InFileName, 'w')
#  f.write("%s\n" % i)
#  f.close()
#  OutFileName = "%02d.a" % test
#  f = open(OutFileName, 'w')
##  f.write("%d\n" % sol(i))
 # f.close()
#  test += 1
#print 'done'

# Check all 
call('run.exe')