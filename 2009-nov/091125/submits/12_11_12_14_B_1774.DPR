program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

VAR m,n,i,j,c:integer;
s:string;

begin
assign(input, 'b.in');
reset(input);
assign(output, 'b.out');
rewrite(output);

read(n,m);
s:='';
for i:= 1 to n do
  for j:= 1 to i do
    s:=s+inttostr(i);


c:=length(s);

for i:=1 to (c div m)+1 do begin
  //for j:= 1 to m do begin
    writeln(copy(s,1,m));
    delete(s,1,m);
end;




end.
