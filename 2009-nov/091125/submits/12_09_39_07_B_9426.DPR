program ZADB;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var n,m,j,i,k:integer;
s:widestring;
begin
 reset(input,'b.in');
 rewrite(output,'b.out');
 read(n,m);
 for I:=1 to n do begin
   for j:=1 to i do begin
    s:=s+inttostr(i);
   end;
   end;

k:=0;
for I:=1 to 10000 do begin
   for j:=1 to m do begin
     inc(k);


     write(s[k]);  if k=length(s) then halt;
     end;
writeln;
end;
end.
