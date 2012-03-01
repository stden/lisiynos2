program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
n,i,j:integer;
a,b:array[0..50,0..50]of integer;

procedure dfs(c,d:integer);
begin
  if b[c,d-1]<=b[c-1,d] then
b[c,d]:=a[c,d]+b[c-1,d] else
b[c,d]:=a[c,d]+b[c,d-1];
if c<n then
dfs(c+1,d);
if d<n then
dfs(c,d+1);
end;

begin
assign(input, 'd.in');
reset(input);
assign(output, 'd.out');
rewrite(output);
readln(n);

for i:= 1 to n do
//readln;
  for j:= 1 to n do
    read(a[i,j]);
dfs(1,1);

writeln(b[n,n]);
close(input);
close(output);

end.
