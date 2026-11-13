Program Turtle;
var a:array [1..50,1..50] of int64;
    B:array [0..50,0..50] of int64;
var i,j,N:integer;
begin
  Assign(Input,'d.in'); Reset(Input);
  Assign(Output,'d.out'); Rewrite(Output);
  Readln(N);     
  for i:=1 to N do
    begin
      for j:=1 to N-1 do
        read(A[i,j]);
      readln(A[i,N])
    end;
  for i:=0 to N do
    begin
      B[i,0]:=0;
      B[0,j]:=0
    end;
  for i:=1 to N do
    for j:=1 to N do
      if B[i-1,j]>B[i,j-1] then B[i,j]:=B[i-1,j]+A[i,j]
                           else B[i,j]:=B[i,j-1]+A[i,j];
  writeln(B[N,N]);
End.