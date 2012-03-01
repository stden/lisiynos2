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

compile('e_make.dpr')

print 'Generate tests: '
test = 1
InFileName = "%02d" % test
while os.path.isfile(InFileName):
  OutFileName = "%02d.a" % test
  t = "e_make.exe "+InFileName+" "+OutFileName
  call("e_make.exe "+InFileName+" "+OutFileName)
  print t
  test += 1
  InFileName = "%02d" % test

# Check all 
call('run.exe')