program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var max,n,a,k,m,c:int64;
i:integer;
begin
  reset(input,'weight.in');
  rewrite(output,'weight.out');
  read(n);
  a:=0;
  k:=1;
  max:=0;
  for i:=1 to n do begin
    read(m);
    read(c);
    if c<a then begin
    a:=m;
    k:=1;
    end
      else begin
      a:=a+m;
      inc(k);
      end;
    if k>max then max:=k;
  end;
  writeln(max);
end.
