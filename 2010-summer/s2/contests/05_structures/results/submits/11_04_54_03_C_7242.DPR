{$O-}
program c;

Var n,m,i,e,o,r,l:longint;
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
  L:=1;
  r:=n;
  For i:=1 to m do
  begin
      L:=1;
  r:=n;
    while l<r do
    begin
      e:=(l+r) div 2;
      if (a[e]<b[i]) then
      L:=e+1
      else
      begin
      if a[e]=b[i] then begin o:=1; break; end  else
      r:=e;
      end
    end;
    Writeln(o);
    o:=0;
  end;
  close(output);
  close(input);

end.
