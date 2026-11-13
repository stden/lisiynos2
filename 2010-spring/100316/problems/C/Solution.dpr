{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{--$M 16384,0,655360}
{$APPTYPE CONSOLE}
{Andrey Pestov. Solution 3}
Const MaxN=100;
      InputFile='C.In';
      OutputFile='C.Out';
Var A: Array[1..MaxN, 1..MaxN] Of Byte;
    N, M: Integer;
    sqa: Integer;

    tlf: Array[1..MaxN, 0..MaxN] Of Byte;

 Procedure Init;
  Var i, j: Integer;
      S: String;
   Begin
    Assign(Input, InputFile);
     Reset(Input);
      Read(N, M);
        For i:=1 To N Do
        For j:=1 To M Do Read(A[i, j]);
     Close(Input);

     FillChar(tlf, SizeOf(tlf), 0);
   End;

 Function Min(Const lf, rg: Integer): Integer;
  Begin
    If lf<rg Then Min:=lf Else Min:=rg;
  End;

 Procedure Solve;
  Var i, j, k, nx: Integer;
   Begin
     sqa:=0;

     For i:=1 To N Do
     For j:=1 To M Do
       If A[i, j]=0 Then tlf[i, j]:=tlf[i, j-1]+1 Else tlf[i, j]:=0;

     For i:=1 To N Do
     For j:=1 To M Do Begin
        nx:=tlf[i, j];
        For k:=i DownTo 1 Do Begin
          nx:=Min(nx, tlf[k, j]);
          If nx*(i-k+1)>sqa Then sqa:=nx*(i-k+1);
        End;
     End;
   End;

 Procedure Done;
  Begin
   Assign(Output, OutputFile);
    Rewrite(Output);
      WriteLn(sqa);
    Close(Output);
  End;

BEGIN
 Init;
  Solve;
 Done;
 END.