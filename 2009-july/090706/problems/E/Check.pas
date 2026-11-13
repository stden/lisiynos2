{ Программа тестирования задачи "Многоугольник" }
{ (c) 1996 Антон Лапунов }
uses TESTLIB, symbols;

var s,t : string;

begin
  s := Compress(ans.ReadString);
  t := Compress(ouf.ReadString);

  if s <> t then QUIT(_WA, 'Ожидалось ' + s + ', а не ' + t);
  QUIT(_OK, '');
end.