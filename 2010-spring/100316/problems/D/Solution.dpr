{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{--$M 16384,0,655360}
{$APPTYPE CONSOLE}
{Andrey Pestov. Solution 4.}
Const InputFile='D.In';
      OutputFile='D.Out';
      MaxN=180;
      MaxK=80;
Var Pr: Array[1..MaxN] Of LongInt;
    N, sK: Integer;

    A: Array[1..MaxN+1, 0..MaxK] Of LongInt;


 Procedure Init;
  Var i: Integer;
   Begin
    Assign(Input, InputFile);
     Reset(Input);
      Read(N);
      For i:=1 To N Do Read(Pr[i]);
      Read(sK);
     Close(Input);
     FillChar(A, SizeOf(A), 0);
   End;

 Function Max(Const lf, rg: LongInt): LongInt;
  Begin
    If lf>rg Then Max:=lf Else Max:=rg;
  End;

 Procedure Solve;
  Var i, j: Integer;
      sum: LongInt;
   Begin
     sum:=0;

     For i:=N DownTo 1 Do Begin
        sum:=sum + Pr[i];
        For j:=1 To sK Do Begin
          A[i, j]:=A[i, j-1];
          If i+j<N+2 Then A[i, j]:=Max(A[i, j], sum - A[i+j, j]);
        End;
     End;
   End;

 Procedure Done;
  Begin
   Assign(Output, OutputFile);
    Rewrite(Output);
      WriteLn(A[1, sK]);
    Close(Output);
  End;

BEGIN
 Init;
  Solve;
 Done;
END.