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

