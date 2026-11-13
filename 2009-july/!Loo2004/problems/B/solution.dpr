{
  Решение к задаче "B. Диагональные Суммы"
  Автор: Степуленок Д.О.
}
 
const MaxN = 100; MaxA = 10000; MinA = 0;

var
  A : array [1..MaxN,1..MaxN] of longint;
  N,i,j,dir,diag : integer;
  sum : longint;
begin
  assign(input,'b.in'); reset(input);
  assign(output,'b.out'); rewrite(output);
  {read}
  read(N);
  if (N<1) or (N>MaxN) then RunError(239);
  fillChar(A,sizeOf(A),0);
  for i:=1 to N do
    for j:=1 to N do begin
      read(A[i,j]);
      if ((A[i,j]<MinA) or (A[i,j]>MaxA)) then RunError(239);
    end;
  {}
  for dir:=0 to 1 do begin
    for diag:=(N-1) downto -(N-1) do begin
      sum:=0;
      for i:=1 to N do begin
        j:=i+diag;
        if dir=1 then j:=N-j+1;
        if ((i>=1) and (i<=N) and (j>=1) and (j<=N)) then
          sum:=sum+A[i,j]
      end;
      write(sum,' ');
    end;
    writeln;
  end;
end.
