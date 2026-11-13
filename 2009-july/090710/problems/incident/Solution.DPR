program incident;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  e: array[1..100,1..2] of int64;
 n,m,i,j:integer;

begin
assign(input,'incident.in'); reset(input);
assign(output,'incident.out'); rewrite(output);
readln(n,m);
for i:=1 to n do begin
read(e[i,1],e[i,2]);
end;
for i:=1 to n do begin
  for j:=1 to m do begin
    if (e[j,1]=i) or(e[j,2]=i) then
    write('1')
    else
    write('0');
    write(' ');
  end;
writeln;
end;
end.


