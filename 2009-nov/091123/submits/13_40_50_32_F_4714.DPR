program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
d:array[1..30,0..2] of int64;
i,ans,n:integer;

begin
  assign(f,'f.in');
  assign(t,'f.out');
  reset(f);
  rewrite(t);
  d[1,0]:=1;
  d[1,1]:=1;
  d[1,2]:=0;

  read(f,n);
  for i:=2 to n do begin
    d[i,0]:=d[i-1,0]+d[i-1,1]+d[i-1,2];
    d[i,1]:=d[i-1,0];
    d[i,2]:=d[i-1,1];
  end;
  ans:=(int64(1) shl n )-d[n,0]-d[n,1]-d[n,2];

  writeln(t,ans);
  close(f);
  close(t);
end.
