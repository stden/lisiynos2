# -*- coding: windows-1251 -*-
import os.path

# Переименование тестов
# Шаблон исходных файлов с тестами
# Шаблон на выходе, обычно "%02d" для входных и "%02d.a" для выходных
# start - номер первого теста из этой выборки
def tests_rename(pattern_from,pattern_to,start=1):
  test = 1
  OldName = pattern_from % test   # Подставляем номер теста
  while os.path.isfile(OldName):
    NewName = pattern_to % (test-1+start)
    print OldName + ' -> ' + NewName
    os.rename(OldName, NewName)
    test += 1
    OldName = pattern_from % test
  
tests_rename("INPUT%02d.TXT","%02d",2)
tests_rename("ANSWER%02d.TXT","%02d.a",2)