program E1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f1,f2: text;
    k,i,n,j: longint;
    a: array[1..1000000] of longint;
begin
   assign(f1,'sort.in'); reset(f1);
   assign(f2,'sort.out'); rewrite(f2);
   readln(f1,n);
   for i:=1 to n do read(f1,a[i]);
   close(f1);
   for j:=1 to n do
     begin
     k:=maxlongint;
     for i:=j to n do
      begin
      if a[i]<k then
        begin
         k:=a[i];
         a[i]:=a[j];
         a[j]:=k;
        end;
      end;
     end;
   for i:=1 to n do write(f2,a[i],' ');
   close(f2);
  { TODO -oUser -cConsole Main : Insert code here }
end.
