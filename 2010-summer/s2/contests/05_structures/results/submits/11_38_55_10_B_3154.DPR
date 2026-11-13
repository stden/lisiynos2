 program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var i,k,l,m,n,kuses:longint;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'heap.in');
  assign(output,'heap.out');
  read(n);
  l:=0;
  m:=0;
  kuses:=0;
  for i:=1 to n do
  begin
  read(k);
  if k=1 then
  begin
    writeln(l);
    l:=m;
    readln
  end else begin
   {writeln('k<>1');}
    read(m);
    if (m>l) or (kuses>1) then
     l:=m; readln;
   end;


 end;
end.
