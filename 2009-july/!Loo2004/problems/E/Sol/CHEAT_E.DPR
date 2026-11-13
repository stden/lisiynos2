{
  Неверное решение к задаче "E. Вещественное число"
  Автор: Степулёнок Д.О.
  Используется процедура VAL
}

{$APPTYPE CONSOLE}

var n,test,err : Integer;
  e : extended;
  s : string;
begin
  assign(input,'e.in'); reset(input);
  assign(output,'e.out'); rewrite(output);
  {}
  readln(n);
  for test:=1 to n do begin
    readln(s);
    if length(s) > 255  then RunError(239);
    val(s,e,err);
    if s[length(s)]='0' then err:=-1;
    if err=0 then writeln('Yes') else writeln('No');
  end;
end.