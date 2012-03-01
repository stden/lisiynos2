{$APPTYPE CONSOLE}

uses SysUtils;

const MaxN = 10000000;
{ Решето Эратосфена }
var 
  simple : array [2..MaxN] of Boolean; 
  N,M,i,j : Integer;
begin
  assign(input,'c1.in'); reset(input);
  assign(output,'c1.out'); rewrite(output);
  { Ввод исходных данных: числа N и M до которого искать простые числа }
  read(M,N);
  { Ввод исходных данных: число N до которого искать простые числа }
  { Первая строка содержит два натуральных числа $N$ и $M$. ($1 \le M \le N \le 10000000$). }
  for i := 2 to N do 
    simple[i] := true;  
  for i := 2 to N do 
    if simple[i] then begin
      j := i + i;
      while j <= N do begin
        simple[j] := false;  
        j := j + i;
      end;  
    end;
  { Вывод результата - всех простых чисел от 2 до N }  
  for i := M to N do
    if simple[i] then Write(i,' ');
end.

