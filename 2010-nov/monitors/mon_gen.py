# -*- coding: utf-8 -*-
from subprocess import call

class Team:
  """ Команда """
  id = 0 # id команды
  name = ""
  solved = set() # Решённые задачи
  time = 0 # Штрафных минут

  def __init__(self):
    self.solved = set()
    self.time = 0

  def submit(self, task_id, no, second, result, test=0):
    """ Отправка решения """
    # Если задача уже была решена, то игнорируем попытку
    if task_id in self.solved: return
    # Время в минутах
    minutes = (int(second) + 25) / 60
    # Анализируем результат (важны только успешные сдачи)
    if result == "OK":
      # Задача удачно сдана
      self.time += minutes + (int(no) - 1) * 20 # добавляем в штрафное время текущее время
      self.solved.add(task_id) # а задачу в список решённых
      
  def __str__(self):
    """ В виде строки """
    return "%s %d %d" % (self.name, len(self.solved), self.time)

class Contest:
  teams = []
  pass

class Problem:
  """ Задача """
  pass

def ParseMonitor(FileName):
  # Открываем лог контеста на чтение и читаем его целиком в строку
  f = open(FileName, "rb")
  text = f.read()
  f.close()
  # Разделяем текст по символу EOF (1A) и раскодируем из кодировки Windows-1251
  data = (text.split('\x1a')[1]).decode('cp1251')
  # Контест
  c = Contest()
  # Команды
  teams = {}
  # Делим на строки по переносам строки
  lines = data.split('\x0d\x0a')
  for line in lines:
    # Игнорируем пустые строки
    if not len(line): continue
    # Отделяем команду (она отделена пробелом)
    s = line.split()
    cmd = s[0]
    # и её аргументы (если есть)
    str = " ".join(s[1:])
    arg = str.split(',')
    if cmd == "@contest": # Название контеста
      c.ContestName = str
    elif cmd == "@startat": # Начало контеста
      c.StartAt = str
    elif cmd == "@contlen": # Длина контеста в минутах
      c.ContLen = str
    elif cmd == "@now": # Секунда сейчас
      c.Now = str
    elif cmd == "@state": # Состояние соревнования
      c.State = str
    elif cmd == "@freeze":
      c.Freeze = str
    elif cmd == "@problems": # Количество задач
      c.Problems = str
    elif cmd == "@teams": # Количество команд
      c.Teams = str
    elif cmd == "@submissions": # Количество посылок (сабмитов)
      c.Submissions = str
    elif cmd == "@p": # Данные о задачах нам пока не нужны (достаточно только их id)
      id, name, points, unknown = arg
    elif cmd == "@t":
      # @t 11,0,1,Иванов Иван Иванович
      t = Team()
      t.id, t.u0, t.u1, t.name = arg
      teams[t.id] = t # Добавляем команду в словарь
    elif cmd == "@s": # @s 14,A6,3,427038,ML,35
      if len(arg) == 5:
        team_id, task_id, no, second, result = arg
        teams[team_id].submit(task_id, no, second, result)
      elif len(arg) == 6:
        team_id, task_id, no, second, result, test = arg
        teams[team_id].submit(task_id, no, second, result, test)
      else:
        raise Exception("Unknown format " + arg)
    else:
      print 'Unknown command "' + cmd + '" arg =', arg
  c.teams = teams.values() # Преобразуем словарь в список
  return c

# Сортировка участников по результатам
def TeamCmpFunc(c1, c2):
  if len(c1.solved) < len(c2.solved): return 1
  if len(c1.solved) > len(c2.solved): return -1
  if c1.time > c2.time: return 1
  if c1.time < c2.time: return -1
  return 0

# Генерация выходного файла
TexFileName = "rating.tex"
tex = open(TexFileName, "w")
tex.write("\\documentclass[20pt]{article}\n")
tex.write("\\usepackage[T2A]{fontenc}\n")
tex.write("\\usepackage[utf8]{inputenc}\n")
tex.write("\\usepackage[english,russian]{babel}\n")
tex.write("\\usepackage{amsmath}\n")
tex.write("\\usepackage{amssymb}\n")
tex.write("\\usepackage{amsfonts}\n")
tex.write("\\usepackage{amsthm}\n")
tex.write("\\renewcommand{\\t}{\\texttt}\n")
tex.write("\\pagestyle{empty}\n")
tex.write("\\oddsidemargin -1.0cm\n")
tex.write("\\evensidemargin 0.0in\n")
tex.write("\\headheight 0.0in\n")
tex.write("\\topmargin 0.0in\n")
tex.write("\\leftmargin -1.0cm\n")
tex.write("\\textwidth=17cm\n")
tex.write("\\textheight=24cm\n")
tex.write("\\begin{document}\n")

def gen_table(C, tex):
  tex.write("\\begin{tabular}{ | c | c | c | }\n")
  tex.write("  \\hline\n")
  count = 0
  for t in C.teams:
    if t.name.find("Cheater") != -1 or t.name.encode("utf-8").find("Я верю") != -1: continue
    count += 1
    name_utf = t.name.encode("utf-8")
    solved = "%d" % len(t.solved)
    time = "%d" % t.time
    tex.write("  " + ("%d" % count) + " & " + name_utf + " & " + solved + " (" + time + ") \\\\ \\hline \n")
  tex.write("\\end{tabular}\n")

# Читаем и сортируем файл
C = ParseMonitor("jms6.dat")
C.teams.sort(cmp=TeamCmpFunc)

tex.write("\n")
tex.write("Рейтинг: " + C.ContestName.encode("utf-8") + " (старшая группа)\n\n\n")

gen_table(C, tex)
tex.write("\n\n\\vspace{30 mm}\n\n")

C = ParseMonitor("jms3.dat")
C.teams.sort(cmp=TeamCmpFunc)

tex.write("\n")
tex.write("Рейтинг: " + C.ContestName.encode("utf-8") + " (младшая группа)\n\n\n")

gen_table(C, tex)

tex.write("\\end{document}\n")
tex.close()

# Создаём итоговый PDF файл
import os
call("pdflatex "+TexFileName)



  