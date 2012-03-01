program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,n,j,m,e,k,r:integer;
a:array[1..4] of integer;

begin
  reset(input,'d.in');
  rewrite(output,'d.out');
  read(n);
  m:=1;
  e:=1;
  k:=1;
  while m<=n do begin
   if k>e then begin
   inc(e);
   k:=1;
   end;
    r:=k;
        if k=1000 then begin
          a[1]:=1;
          a[2]:=0;
          a[3]:=0;
          a[4]:=0;
          m:=m+4;
        end else
        if k>=100 then begin
          a[2]:=k div 100;
          k:=k mod 100;
          a[3]:=k div 10;
          k:=k mod 10;
          a[4]:=k;
          m:=m+3;
        end else
        if k>=10 then begin

          a[3]:=k div 10;
          a[4]:=k mod 10;
          m:=m+2;
        end else begin

          a[4]:=k;
          inc(m);
        end;
    k:=r+1;

  end;
  writeln(a[4-m+n+1]);





end.
