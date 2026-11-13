program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;


var
dir:array[1..5000] of string;
dir2:array[1..5000] of boolean;
m,n,i,j:integer;
fil,text:string;

function ost(s:string):string;
var c,b,p:integer;
s1,s2:string;
begin
b:=length(s);
s1:='';
for c:= 0 to b-1 do begin
  s1:=s1+s[b-c];
  end;
p:=pos('\',s1);
ost:=copy(s, 0, b-p);
end;

function name(s:string):string;
var c,b,p:integer;
s1,s2:string;
begin
b:=length(s);
s1:='';
for c:= 0 to b-1 do begin
  s1:=s1+s[b-c];
  end;
p:=pos('\',s1);
name:=copy(s, b-p+2, p);
end;    

begin
reset(input, 'lostdir.in');
rewrite(output, 'lostdir.out');
readln(m,n);

for i:= 1 to m do
  readln(dir[i]);


for i:= 1 to n do begin
  readln(fil);
  text:=fil;
  while length(text)>3 do begin
  text:=ost(text);
  for j:= 1 to m do
    if dir[j]=text then
      dir2[j]:=true;
  end;
end;

  for j:= 1 to m do
    if dir2[j]=false then
      writeln(name(dir[j]));

end.
