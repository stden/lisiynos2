program Project2;

{$APPTYPE CONSOLE}


uses
  SysUtils;

{const
n:array[1..7]of integer
  n[1]='APTECHKA';
  n[2]='AVTOMAT';
  n[3]='NOGH';
  n='NOSKI';
  n='PORTIANKI';
  n='SCHETKA';
  n='SHLEM';
       }

var name:array[1..7]of string;
s:array[1..7]of integer;
n,i,j:integer;
f:string;
begin
assign(input, 'stuffbag.in');
reset(input);
assign(output,'stuffbag.out');
rewrite(output);
         
for j:= 1 to 7 do
s[j]:=0;
name[1]:='APTECHKA';
name[2]:='AVTOMAT';
name[3]:='NOGH';
name[4]:='NOSKI';
name[5]:='PORTIANKI';
name[6]:='SCHETKA';
name[7]:='SHLEM';
readln(n);
for i:= 1 to n do begin
readln(f);
for j:= 1 to 7 do
  if f = name[j] then
    s[j]:=s[j]+1;
end;


for i:= 1 to 7 do
  for j:= 1 to s[i] do
    writeln(name[i]);



end.
