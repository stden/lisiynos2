{
Решение к задаче B."Диагональные Суммы"
Автор: Зубарев П.С.
}
{$APPTYPE CONSOLE}
Const Max_N = 200;

Var N, I, J, K : Longint;
    Pole: Array [1..Max_N,1..Max_N] of Longint;
    Ans : Array [0..Max_N] Of Longint;

Function Check(X,Y : Longint):Boolean;
Begin
  Check :=((X>=1) And (X<=N)) And ((Y>=1)And(Y<=N));
End;

begin
  Assign(input,'b.in');Reset(input);
  Assign(output,'b.out');Rewrite(output);
  Read(n);
  For i:=1 to N do
    For j:=1 to N do
      Read(Pole[i,j]);
  For k:=-n to n do
    For i:=1 to N+1 do
      If Check(i-1,i+k) then
         Ans[n+k]:=Ans[n+k]+Pole[i-1,i+k];
  For i:=2*(n-1) downto 0 do Write(Ans[i],' ');
  Writeln;
  For i:=0 to Max_n do Ans[i]:=0;
  For k:=-n to n do
    For i:=1 to N+1 do
      If Check(i-1,n-i+1+k) then
         Ans[n+k]:=Ans[n+k]+Pole[i-1,n-i+1+k];
  For i:=2 to 2*n do Write(Ans[i],' ');
  Writeln;
end.
