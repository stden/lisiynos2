program a5;
type tm=array[1..100000]of longint;
var mas:tm;
  mas1,mas2,mas3:tm;
  i,j,k,k1,n,m:integer;

begin
  assign(input,'collect.in');
  assign(output,'collect.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
  read(mas1[i]);
  readln(m);
  for i:=1 to m do
  read(mas2[i]);
  for i:=1 to m do
  begin
  k := 0;
  j := n + 1;
  while k < j - 1 do begin
    k1:= (k + j) div 2;
    if mas2[i] <= mas1[k1] then
      j := k1
    else
      k := k1;
  end;
  if (j > 0) and (mas1[j] = mas2[i]) then begin
    mas3[i]:=1;
  end;
  end;
      for i:=1 to m do writeln(mas3[i]);
      close(input);
      close(output);
end.
