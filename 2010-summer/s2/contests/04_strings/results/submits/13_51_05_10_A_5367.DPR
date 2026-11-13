program proga1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var s1,s2:string;
points:integer;

  function search(s1:string;s2:string):integer;
  var i,j,m,t,k,c:integer;
  {points:array[1..100] of integer;}
  j2:string;
  begin
  search:=0;
  m:=2;
  for i:=2 to 16 do begin
  m:=2*m;
  end;
  for j:=1 to length(s1) do
  c:=0;
  for i:=j to length(s2) do
  c:=c+ord(s1[i]) mod m-1;
  end;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'substr.in'); reset(input);
  assign(output,'substr.out'); rewrite(output);

  readln(s1);
  readln(s2);

writeln('none');


end.
 