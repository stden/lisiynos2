program ZADB;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var n,m,j,i,k:longint;
s:widestring;
begin
 reset(input,'b.in');
 rewrite(output,'b.out');
 read(n,m);       k:=0;
 for I:=1 to n do begin
   for j:=1 to i do begin
    write(inttostr(i));inc(k);
    if (i=n) and (j=i) then halt;

    if k=m then begin writeln; k:=0; end;
   end;
   end;

{k:=0;
for I:=1 to 100000 do begin
   for j:=1 to m do begin
     inc(k);
      write(s[k]);  if k=length(s) then halt;
     end;
writeln;
end;}
end.
