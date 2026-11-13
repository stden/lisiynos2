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

"""def R(f,t): return xrange(f,t+1)

# Solution
Sup = {}

def F(x,y,z):
  if Sup.has_key((x,y,z)):
    return Sup[(x,y,z)]
  if z==1 and x!=1:
    res = 0
  elif y==z and x==y:
    res = 1
  else:
    res = sum( F(i,y-1,z-1) for i in R(1,x-1) ) + sum( F(x,y-1,z) for i in R(x+1,y))
  Sup[(x,y,z)] = res
  return res

def sol(n,p): return sum( F(i,n,p) for i in R(1,n) )

print 'Generate tests: ',
test = 1
for i in ((4,2), (5,4), (6,6), (8,6), (10,7), (15,9), (16,7), (16,8), (16,9), (16,10)):
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

print 'done' """

# Check all 
call('run.exe')