program color;

{$APPTYPE CONSOLE}

uses
  SysUtils;

  var a:array[1..100,1..100] of 1..2;
  b:array[1..100] of 1..3;
  c:array[1..100,1..100] of boolean;
  n,i,j,ch,q:integer;

procedure dfs(v:integer);
var g:integer;
begin
for g:= 1 to n do
  if (a[v,g]=1) and (c[v,g]=false) then begin
  c[v,g]:=true;
  dfs(g);
  if not(b[v]=b[g]) then ch:=ch+1;
end;
end;

begin
assign(input, 'color.in'); reset(input);
assign(output,'color.out'); rewrite(output);
readln(n);
for i:=1 to n do
 for j:=1 to n do begin
 read(a[i,j]);
end;
for i:=1 to n do
read(b[i]);

for q:=1 to n do begin
dfs(q);
end;
ch:=ch div 2;
writeln(ch);
close(input);
close(output);
end.
