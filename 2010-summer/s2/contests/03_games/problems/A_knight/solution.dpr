
var n,m,i,j:integer;
    q:array[1..102,1..102] of int64;
               
begin
  reset(input,'knight.in');
  rewrite(output,'knight.out');
  read(n,m);
  q[1,1]:=1;
  for i:=1 to n do
  for j:=1 to m do begin
   q[i+1,j+2]:=q[i+1,j+2]+q[i,j];
   q[i+2,j+1]:=q[i+2,j+1]+q[i,j];
  end;
  writeln(q[n,m]);
end.