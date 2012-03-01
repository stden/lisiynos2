program c1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
   f1,f2: text;
   i,d,g,times: longint;
   T,F,H:  array[1..100] of longint;
begin
   assign(f1,'well.in');
   assign(f2,'well.out');
   reset(f1);
   rewrite(f2);
   readln(f1,d,g);
   for i:=1 to g do readln(f1,T[i],f[i],h[i]);
   close(f1);
   times:=0;

   for i:=1 to g do
    times:=times+h[i];

   if times>=d then
   writeln(f2,t[g]) else writeln(f2,f[g]);
    close(f2);
  { TODO -oUser -cConsole Main : Insert code here }
end.
