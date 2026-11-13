program name;
   Var a:array [1..100] of integer;
  b:array [1..100,1..100] of integer;
  S,n,i,j:integer;
  Begin
  Assign(input,'tree.in');
  Assign(output,'tree.out');
  Rewrite(output);
  Reset(input);
  n:=0;
  readLn(n);
  S:=0;
   For i:=1 to n do
    For j:=1 to n do
     begin
     Read (b[i,j]);
     end;
   For i:=1 to n do
    For j:=1 to n do
     begin
     if b[i,j]=1 then s:=s+1;
     end;
     if (s/2)+1 = n then write('YES') else write ('NO');
  close(input);
  close(output);
END.