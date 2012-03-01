program Project1;

{$APPTYPE CONSOLE}
uses
  SysUtils;

const
name='Vasiliy Pupkin';
var
s:string;
n,i,j:integer;
begin
assign(input, 'papiros.in');
reset(input);
assign(output, 'papiros.out');
rewrite(output);
j:=0;
readln(n);
for i:= 1 to n do begin
  readln(s);
  if s=name then
    inc(j);
end;
writeln(j-1);
end.
 