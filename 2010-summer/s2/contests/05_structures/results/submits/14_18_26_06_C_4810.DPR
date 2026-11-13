program collect;

{$APPTYPE CONSOLE}
 var
  A,B,C:array [1..100000] of longint;
  N,M,N1,i,M1,l,r:integer;
begin
  assign(input,'collect.in');
  assign(output,'collect.out');
  reset(input);
  rewrite(output);
  readln(N);
  for I := 1 to N do
    read(A[i]);
  readln(M);
  for I := 1 to M do
    read(B[i]);
  for I :=1 to M do
    C[i]:=0;
  for I := 1 to m do
    if a[1]=b[i] then c[i]:=1;

  for I := 1 to M do
   begin
    l:=1;
    r:=N+1;
    while l<r-1 do
     begin
       m1:=(l+r) div 2;
       if a[m1]<=B[i] then l:=m1
                      else r:=m1;
       if a[m1]=B[i] then c[i]:=1;

      end;
    end;
 for I := 1 to M do
   writeln(c[i]);
   close(input);
close(output);
end.

