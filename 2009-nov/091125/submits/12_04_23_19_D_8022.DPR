program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

VAR m,n,i,j,c:integer;
s:string;

begin
assign(input, 'd.in');
reset(input);
assign(output, 'd.out');
rewrite(output);

read(n);
s:='';
for i:= 1 to n do
  //while length(s)<n do
    for j:= 1 to i do
      s:=s+inttostr(j);

writeln(s[n]);





end.
