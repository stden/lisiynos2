{$apptype console}

uses SysUtils;

var
  i:Integer;
  Start,Diff : TDateTime;
  A1,B1,C1 : Longint;
  A2,B2,C2 : Longint;
  a,b : Int64;
begin
  assign(input,'par.in'); reset(input);
  assign(output,'par.out'); rewrite(output);
  repeat
    { Чтение исходных данных }
    read(A1,B1,C1);
    if (A1=0) and (B1=0) and (C1=0) then 
      break;
    read(A2,B2,C2);
    { Решение задачи }
    if A1*B2 = A2*B1 then
      writeln('YES')
    else 
      writeln('NO');
  until false;
end.