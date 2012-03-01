program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..10000] of char;
i,u,j,k,n,m:integer;

begin
  reset(input,'b.in');
  rewrite(output,'b.out');
  read(n,m);
  u:=0;
  for i:=1 to n do
    for j:=1 to i do begin

      k:=i;

        if k div 1000 <>0 then begin;
          inc(u);
          a[u]:=inttostr(k div 1000)[1];
          k:=k mod 1000;
        end;
        if k div 100 <> 0 then begin
          inc(u);
          a[u]:=inttostr(k div 100)[1];
          k:=k mod 100;
        end;
        if k div 10 <> 0 then begin
          inc(u);
          a[u]:=inttostr(k div 10)[1];
          k:=k mod 10;
        end;
        if k<> 0 then begin
          inc(u);
          a[u]:=inttostr(k)[1];
          k:=0;
        end;
        
    end;
  n:=u;
  u:=0;
  i:=0;
  while i<n do begin
    inc(i);
    write(a[i]);
    if i mod m =0 then writeln;
  end;
  if i mod m <>0 then writeln;
end.
