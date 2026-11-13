program svetofori;
var a:array[1..100] of longint;
    n,m,i,x,y:integer;
begin
 assign(input,'light.in');
 reset(input);
 assign(output,'light.out');
 rewrite(output);
 readln(n,m);
  for i:=1 to m do begin
   readln(x,y);
   inc(a[x]);
   inc(a[y]);
  end;
  for i:=1 to n do write(a[i],' ');
 writeln;
 readln;
End.