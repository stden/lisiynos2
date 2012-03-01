{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{--$M 16384,0,655360}
{--$N+}

{$APPTYPE CONSOLE}
{Andrey Pestov. Solution 1}
Const InputFile='A.In';
      OutputFile='A.Out';
      MaxN=12;
 Var A: Array[1..MaxN] Of Integer;
     N: Integer;
     rB: LongInt;
     res: String;
     B: Array[1..MaxN] Of Char;

 Procedure Init;
  Var i: Integer;
   Begin
    Assign(Input, InputFile);
     Reset(Input);
      Read(rB, N);
      For i:=1 To N Do Read(A[i]);
     Close(Input);
   End;

 Function GetMul(Var p: Integer): Comp;
  Var tm: Comp;
   Begin
    tm:=A[p];
     While (p<N) And (B[p]='*') Do Begin
       tm:=tm*A[p+1];
       Inc(p);
     End;
    GetMul:=tm;
   End;

 Function GetRes(Var p: Integer): Comp;
  Var tm: Comp;
   Begin
     tm:=GetMul(p);
     While (p<N) And (B[p] In ['+', '-']) Do Begin
       Inc(p);
       Case B[p-1] Of
         '+': tm:=tm+GetMul(p);
         '-': tm:=tm-GetMul(p);
       End;
     End;
     GetRes:=tm;
   End;

 Procedure Done;
  Begin
   Assign(Output, OutputFile);
    Rewrite(Output);
     WriteLn(res);
    Close(Output);
  End;

 Procedure Check;
  Var num: Comp;
      i: Integer;
      p: String;
   Begin
    i:=1;
    num:=GetRes(i);
    If num=rB Then Begin
      Str(A[1], res);
       For i:=2 To N Do Begin
         str(A[i], p);
         res:=res+B[i-1]+p;
       End;
      Done;
      Halt;
    End;
   End;

 Procedure Rec(Const k: Integer);
  Begin
   If k=N Then Check
    Else Begin
      B[k]:='+'; Rec(k+1);
      B[k]:='-'; Rec(k+1);
      B[k]:='*'; Rec(k+1);
    End;
  End;

 Procedure Solve;
  Begin
   res:='0';
   Rec(1);
  End;

BEGIN
 Init;
  Solve;
 Done;
END.