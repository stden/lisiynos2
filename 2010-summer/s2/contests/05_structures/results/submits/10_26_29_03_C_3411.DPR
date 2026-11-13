program c;

Var n,m,i,e,r,l:longint;
a:array [1..100000] of longint;
b:array [1..100000] of longint;

begin
  Assign(input,'collect.in');
  Assign(output,'collect.out');
  Rewrite(output);
  Reset(input);
  Readln(n);
  For i:=1 to n do
  Read (a[i]);
  ReadLn;
  ReadLn(m);
  For i:=1 to m do
  Read (b[i]);
  ReadLn;
  L:=a[1];
  r:=a[n];
  For I:=1 to m do
  begin
    while l<r do
    begin
      e:=(l+r) div 2;
      if (a[e]<b[m]) then
      L:=e+1
      else
      r:=e;
    end;
    if a[l]=b[m] then writeln (1) else writeln(0);
  end;
  close(output);
  close(input);

end.
