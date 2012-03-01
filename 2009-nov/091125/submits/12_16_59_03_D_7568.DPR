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
    for j:= 1 to i do begin
        s:=s+inttostr(j);
        if length(s)>=n then
        break;
    end;

writeln(s[n]);





end.
