{ ѓҐ­Ґа в®а вҐбв®ў Є § ¤ зҐ H: "ђлж аЁ ЄагЈ«®Ј® бв®« " }
{$APPTYPE CONSOLE}
const max = 1000000;
var n,i,j : longint;
    x,y : array [1..100] of longint;
    newtown : boolean;
begin
  randomize;
  {}
  assign(output,'h.in'); rewrite(output);
  {}
  n := 100;
  writeln(n);
  { Генерация положения городов и вывод их координат в файл }
  for i:=1 to n do begin
    repeat
      x[i] := random(max)+1;
      y[i] := random(max)+1;
      { Проверяем, не совпадает ли с одним из предыдущих городов }
      newtown := true;
      for j:=1 to n do
        if ((i<>j) and (x[i]=x[j]) and (y[i]=y[j])) then begin
          newtown := false;
          break; { Надо еще раз перегенерировать }
        end;
      if not newtown then continue;
    until true;
    writeln(x[i],' ',y[i]);
  end;
end.
