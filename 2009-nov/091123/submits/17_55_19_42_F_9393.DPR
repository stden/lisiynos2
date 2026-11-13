program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var f1,f2:text;
    n,i:integer;
    a:array[1..100,1..3] of integer;
    t:array[1..3] of integer;
procedure sort(k:integer);
 var i,j:integer;
 begin
  for i:=n downto 1 do
   for j:=1 to i do
    if a[j,k]>a[i,k] then
     begin
      t[1]:=a[j,1];
      t[2]:=a[j,2];
      t[3]:=a[j,3];
      a[j,1]:=a[i,1];
      a[j,2]:=a[i,2];
      a[j,3]:=a[i,3];
      a[i,1]:=t[1];
      a[i,2]:=t[2];
      a[i,3]:=t[3];
     end;
 end;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(f1,'time.in');
  reset(f1);
  assign(f2,'time.out');
  rewrite(f2);
  readln(f1,n);
  for i:=1 to n do
   read(f1,a[i,1],a[i,2],a[i,3]);
  sort(1);
  sort(2);
  sort(3);
  for i:=1 to n do
   begin
    write(f2,a[i,1],' ');
    write(f2,a[i,2],' ');
    writeln(f2,a[i,3]);
   end; 
  close(f1);
  close(f2);
end.
