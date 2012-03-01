using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Collections;

namespace SolGen
{
  class Program
  {
    static Encoding myEncoding = Encoding.GetEncoding("Windows-1251");

    static void Main(string[] args)
    {
      ArrayList Tasks = new ArrayList();
      string bfComment = "Неправильное решение методом грубой силы!";
      // Функции
      string sumdig = @"
// Сумма цифр числа t
function sumDig( t : longint ) : longint;
begin
  result := 0;
  while t > 0 do begin
    inc( result, t mod 10 );
    t := t div 10;
  end;
end;";
      // Специфика задач
      Task A = new Task();
      A.Name = "A. Муравьи на кубической земле";
      A.TaskShortName = "ants";
      A.InExample = @"2 4
2 2 N
4 3 W";
      A.OutExample = @"66";
      A.notBF = true;
      A.Limits = @"
const
  max_n = 100000;
  max_m = 15000;";
      A.Vars = @"
var
  n : longint; // количество муравьев на земле
  m : longint; // длина стороны планеты
  x, y : longint; // координаты муравья
  ns_cnt : longint; // количество незанятых с севера на юг
  we_cnt : longint; // количество незанятых с запада на восток
  ns : array [1..max_m] of boolean; // занята ли полоса?
  we : array [1..max_m] of boolean; // занята ли полоса?
  _type : char; // направление движения муравья
  temp : char; // временная переменная для чтения из файла
  i, j : longint;";
      A.Read = @"
  readln( n, m );
  assert( (1 <= n) and (n <= max_n) );
  assert( (1 <= m) and (m <= max_m) );
  fillchar( ns, sizeof(ns), false );
  fillchar( we, sizeof(we), false );
  for i:=1 to n do begin
    readln( x, y, temp, _type );
    assert( _type in ['N','S','W','E'] );
    // Записываем, какие полосы на кубе ""вырезаны"" муравьями
    if _type in ['N','S'] then ns[x] := true;
    if _type in ['W','E'] then we[y] := true;
    // Рисунка в моей копии условия нет, так что я не знаю как ориентированы оси X и Y
    // возможно, вместо двух предыдущих строк нужно написать так:
//    if _type in ['N','S'] then ns[y] := true;  // Расскоментируйте, если нужно :)
//    if _type in ['W','E'] then we[x] := true;
  end;";
      A.Solve = @"
  ns_cnt := 0;  
  we_cnt := 0;
  for i:=1 to m do
    if not ns[i] then
      inc( ns_cnt );
  for i:=1 to m do
    if not we[i] then
      inc( we_cnt );";
      A.WriteAnswer = @"
  write( ns_cnt * we_cnt * 2 + // верхняя и нижняя грань
         (ns_cnt + we_cnt) * m * 2 // боковые грани
       );";
      Tasks.Add(A);

      Task C = new Task();
      string impossible = "impossible";
      string possible = "possible";
      C.Name = "C. Крепость";
      C.TaskShortName = "castle";
      C.InExample = @"0 0
0 1
? ?
? ?
2 2
? ?";
      C.OutExample = @"possible
0.00 0.00
0.00 1.00
0.00 2.00
1.00 2.00
2.00 2.00
1.00 1.00";
      C.notBF = true;
      C.Vars = @"const n = 6;

var
  x, y : array [0..n-1] of double; // координаты вершин
  know : array [0..n-1] of boolean; // известны ли?
  i, j : longint;
  s : string; // временная строка для чтения";
      C.Read = @"
  for i:=0 to n-1 do begin
    readln( s );
    if s = '? ?' then 
      know[i] = false
    else begin
    end;    
  end;";
      C.Solve = @"
  ns_cnt := 0;  
  we_cnt := 0;
  for i:=1 to m do
    if not ns[i] then
      inc( ns_cnt );
  for i:=1 to m do
    if not we[i] then
      inc( we_cnt );";
      C.WriteAnswer = @"
  write( ns_cnt * we_cnt * 2 + // верхняя и нижняя грань
         (ns_cnt + we_cnt) * m * 2 // боковые грани
       );";
      Tasks.Add(C);

/*      Task D = new Task();
      D.Name = "D. Цифры";
      D.TaskShortName = "digits";
      D.Proc = sumdig;
      D.Vars = "var n : integer;";
      D.InExample = "1";
      D.OutExample = "45";
      D.Read = "  read(n); assert( n <= 100000 );";
      D.bfSol = @"  ";
      Tasks.Add(D); */
      // Генерация кода
      foreach (Task t in Tasks)
      {
        string SrcFileName = t.TaskShortName+"_ds.dpr";
        using(StreamWriter sw = new StreamWriter(File.Create(SrcFileName),myEncoding))
        {
          WriteHeader(t,sw);
          if (t.Limits != null)
          {
            sw.WriteLine("// Ограничения из условия задачи");
            sw.WriteLine(t.Limits.TrimStart());
          }
          sw.WriteLine(t.Vars);
          OpenFiles(t, sw);
          sw.WriteLine(@"  // Чтение исходных данных");
          sw.WriteLine("  "+t.Read.TrimStart());
          sw.WriteLine(@"  // Решение");
          sw.WriteLine("  " + t.Solve.TrimStart());
          sw.WriteLine(@"  // Запись результатов");
          sw.WriteLine("  " + t.WriteAnswer.TrimStart());
          sw.WriteLine(@"end.");
        };
        if (!t.notBF)
        {
          SrcFileName = t.TaskShortName + "_bf.dpr";
          using (StreamWriter sw = new StreamWriter(File.Create(SrcFileName), myEncoding))
          {
            WriteHeader(t, sw, bfComment);
            sw.WriteLine(t.Vars);
            OpenFiles(t, sw);
            sw.WriteLine(@"  // Чтение исходных данных");
            sw.WriteLine(t.Read);
            sw.WriteLine(@"  // Решение");
            sw.WriteLine(@"  // Запись результатов");
            sw.WriteLine(@"end.");
          };
        }
        Генерация_входных_и_выходных_файлов( t );
      }
    }

    private static void Генерация_входных_и_выходных_файлов(Task t)
    {
      string inFileName = t.TaskShortName + ".in";
      using (StreamWriter sw = new StreamWriter(File.Create(inFileName), myEncoding))
      {
        sw.Write(t.InExample);
      }
      string outFileName = t.TaskShortName + ".out";
      using (StreamWriter sw = new StreamWriter(File.Create(outFileName), myEncoding))
      {
        sw.Write(t.OutExample);
      }
    }

    private static void OpenFiles(Task t, StreamWriter sw)
    {
      sw.WriteLine(@"begin
  assign(input,'" + t.TaskShortName + @".in'); reset(input);
  assign(output,'" + t.TaskShortName + @".out'); rewrite(output);");
    }

    private static void WriteHeader(Task t, StreamWriter sw)
    {
      WriteHeader(t, sw, null);
    }

    private static void WriteHeader(Task t, StreamWriter sw, string Comment)
    {
      sw.WriteLine(
        @"// Решение к задаче """+t.Name+@"""
// Автор: Степулёнок Д.О.
// E-mail: stden@inruscom.com

uses SysUtils;
");
    }
  }
}
