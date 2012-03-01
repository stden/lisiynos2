{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{--$M 16384,0,655360}
{$APPTYPE CONSOLE}
{Andrey Pestov. Solution 2}
Const InputFile='B.In';
      OutputFile='B.Out';
      MaxN=100;
      MaxK=50;

Type Sset=Set Of 1..50;
Var A: Array[1..MaxN] Of Sset;
    was: Array[1..MaxN] Of Boolean;
    N: Integer;
    cnt: Integer;

 Procedure Init;
  Var i, j, sc, p: Integer;
   Begin
     FillChar(A, SizeOf(A), 0);
     FillChar(was, SizeOf(was), 0);
     cnt:=0;

     Assign(Input, InputFile);
      Reset(Input);
       Read(N);
       For i:=1 To N Do Begin
         Read(sc);
          For j:=1 To sc Do Begin
             Read(p);
             Include(A[i], p);
          End;
       End;
      Close(Input);
   End;

 Procedure Rec(Const p: Integer);
  Var i: Integer;
   Begin
     If was[p] Then Exit;
     was[p]:=True; Inc(cnt);
     For i:=1 To N Do
     If A[i]*A[p]<>[] Then Rec(i);
   End;

 Procedure Done;
  Begin
   Assign(Output, OutputFile);
    Rewrite(Output);
     WriteLn(cnt);
    Close(Output);
  End;

BEGIN
 Init;
  Rec(1);
 Done;
END.