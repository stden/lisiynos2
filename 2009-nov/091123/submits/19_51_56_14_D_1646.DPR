program F1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
    f1,f2: text;
    a: array[1..100,1..3] of byte;
    b: array[1..3] of byte;
    m,n,i,j: longint;
begin
  assign(f1,'time.in');
  assign(f2,'time.out');
  reset(f1);
  rewrite(f2);
  readln(f1,n);
  for i:=1 to n do readln(f1,a[i,1],a[i,2],a[i,3]);
  for j:=1 to n do
   begin
   m:=maxlongint;
   for i:=j to n do
    begin
      if a[i,1]*3600+a[i,2]*60+a[i,3]<m then
          begin
            m:=a[i,1]*3600+a[i,2]*60+a[i,3];
            b[1]:=a[i,1];b[2]:=a[i,2];b[3]:=a[i,3];
            a[i]:=a[j];
            a[j,1]:=b[1];a[j,2]:=b[2]; a[j,3]:=b[3];
          end;
    end;
   writeln(f2,a[j,1],' ',a[j,2],' ',a[j,3]);
   end;
   close(f1);
   close(f2);
  { TODO -oUser -cConsole Main : Insert code here }
end.
