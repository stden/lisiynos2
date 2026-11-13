 program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var i,k,l,m,n:longint;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'heap.in');
  assign(output,'heap.out');
  read(n);
  l:=0;
  for i:=1 to n do begin
  read(k);
  if k=1 then begin writeln(l); l:=0; readln end else begin read(m); if m>l then l:=m; readln; end;
  end;
end.
