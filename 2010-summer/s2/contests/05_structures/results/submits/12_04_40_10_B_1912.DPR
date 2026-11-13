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
  for i:=1 to n do
  begin
  read(k);
  if k=1 then
  begin
    writeln(l);
    readln;
    if kuses>0 then l:=0;
    kuses:=1;
  end else begin
    read(m);
    kuses:=0;
    if (m>l) {and not (kuses=1)} then
     l:=m; readln;
   end;

 end;
end.
