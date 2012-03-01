Program lait;

var
 n,m,i:integer;
 k:array[1..100] of integer;
 x,y:integer;

begin
 reset(input, 'light.in');
 rewrite(output, 'light.out');
 for i:= 1 to 100 do k[i] := 0;
 readln(n,m);
 for i:= 1 to m do begin
  readln(x,y);
  inc(k[x]);
  inc(k[y]);
  end;
 for i := 1 to n do
  write(k[i], ' ');
End.
