program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n,i,m,min,ind,j:integer;
  a: array[1..100] of integer;
begin
  reset(input,'unreal.in');
  rewrite(output,'unreal.out');
  readln(n);
  for i:=1 to n do begin
    a[i]:=0;
    for j:=1 to n-1 do begin
     read(m);
     a[i]:=a[i]+m;
    end;
    readln;
  end;
  min:=a[1];
  ind:=1;
  for i:=2 to n do begin
    if a[i]<min then begin
     min:=min+a[i];
     a[i]:=min-a[i];
     min:=min-a[i];
     ind:=i;
    end;
  end;
  write(ind);

end.
 