program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var max,n,mass:int64;
i,e,b,k:integer;
m,c:array[1..100000] of integer;

begin
  reset(input,'weight.in');
  rewrite(output,'weight.out');
  read(n);
  for i:=1 to n do begin
    read(m[i]);
    read(c[i]);
  end;
  e:=1;
  b:=1;
  mass:=0;
  max:=0;
  k:=0;
  while e<=n do begin
    if mass<=c[e] then begin
    mass:=mass+m[e];
    inc(e);
    inc(k);
    end else
    repeat
    dec(k);
    mass:=mass-m[b];
    inc(b);
    until mass<=c[e];

    if k>max then max:=k;
  end;
  writeln(max);
end.
