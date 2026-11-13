program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  post:array[1..100] of integer;
  point,m:integer;
  n,i,k,e:shortint;
  f1,f2:text;
begin
 assign(f1,'road.in');
 assign(f2,'road.out');
 reset(f1);
 rewrite(f2);
 read(f1,n);
 i:=0;
 k:=0;
 while i<=n-1 do
 begin
 inc(i);
 read(f1,post[i]);
 end;
 read(f1,point);
 m:=maxint;
 while k<=n-1 do
 begin
 inc(k);
 if (abs(point-post[k]))<m then
 begin
 m:=abs(point-post[k]);
 e:=k+1;
 end;
 end;
 write(f2,e);
 close(f1);
 close(f2);
  { TODO -oUser -cConsole Main : Insert code here }
end.
