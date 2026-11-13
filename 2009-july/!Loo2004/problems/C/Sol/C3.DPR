{
  Решение к задаче "C. Сумма простых"
  Автор: Степуленок Д.О.
}

{$APPTYPE CONSOLE}

uses SysUtils;

{ Храним только нечётные числа }

const MaxN = 1000000;

var
  a : array [1..MaxN div 2] of boolean;
  i,q,chislo : integer;
begin
  assign(output,'simple.txt'); rewrite(output);
  {}
  fillChar(a,sizeOf(a),true);
  for i:=1 to (MaxN div 2) do
    if a[i] then begin
      chislo := i*2+1; { Вычисляем реальное число }
      q := chislo+chislo;
      while q<=MaxN do begin
        if odd(q) then a[(q-1) div 2]:=false;
        q:=q+chislo;
      end;
    end;
  {}
  for i:=2 to (MaxN div 2) do
    if a[i-1] and a[i] then
      writeln(2,' ',i*2+1);
  close(output);
end.
