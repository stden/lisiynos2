{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+}
{$M 65384,0,655360}
Program Vulcan;
Const InputFile='Input.txt';
      OutputFile='Output.txt';
Const MaxN=500;
 Var Ax, Ay, Ar: Array[1..MaxN] Of LongInt;
     Ls, sc, whb, hwd: Array[1..MaxN] Of Integer;
     N: Integer;
     mx, mxi: Integer;


 Procedure Init;
  Var i: Integer;
   Begin
    Assign(Input, InputFile);
     Reset(Input);
      Read(N);
       For i:=1 To N Do Read(Ax[i], Ay[i], Ar[i]);
     Close(Input);
   End;

 Procedure Swap(Var a, b: Integer);
  Var c: Integer;
   Begin
    c:=a; a:=b; b:=c;
   End;

 Procedure Sort;
  Var i, j: Integer;
   Begin
    For i:=1 To N-1 Do
    For j:=i+1 To N Do
    If sc[i]>sc[j] Then Begin
     Swap(sc[i], sc[j]);
     Swap(whb[i], whb[j]);
    End;
   End;

 Function Incl(Const x, y: LongInt;Const j: Integer): Boolean;
  Var x1, y1, r: Real;
   Begin
    x1:=x-Ax[j];
    y1:=y-Ay[j];
    r:=Ar[j];
    Incl:=(Sqr(x1) + Sqr(y1))<=(Sqr(r));
   End;

 Function Incld(Const i, j: Integer): Boolean;
  Begin
   Incld:=Incl(Ax[i]+Ar[i], Ay[i], j) And Incl(Ax[i]-Ar[i], Ay[i], j) And
   Incl(Ax[i], Ay[i]+Ar[i], j) And Incl(Ax[i], Ay[i]-Ar[i], j);
  End;

 Procedure Obx;
  Var i, j: Integer;
   Begin
    FillChar(hwd, SizeOf(hwd), 0);
    FillChar(Ls, SizeOf(Ls), 0);
     mx:=1; mxi:=1;
    For i:=1 To N Do hwd[i]:=1;
    For i:=1 To N Do Begin
     For j:=i+1 To N Do
     If Incld(whb[i], whb[j]) And ((hwd[j]<hwd[i]+1)) Then Begin
      Ls[j]:=i;
      hwd[j]:=hwd[i]+1;
     End;
     If hwd[i]>mx Then Begin mxi:=i; mx:=hwd[i]; End;
    End;
   End;

 Procedure Solve;
  Var i, j: Integer;
   Begin
    FillChar(sc, SizeOf(sc), 0);
    For i:=1 To N Do
    For j:=1 To N Do
     If Incld(j, i) Then Inc(sc[i]);
    For i:=1 To N Do whb[i]:=i;
    Sort;
    Obx;
   End;

 Procedure SayRec(Const mi: Integer);
  Begin
   If mi=0 Then Exit;
   SayRec(Ls[mi]);
   Write(whb[mi], ' ');
  End;

 Procedure Done;
  Begin
   Assign(Output, OutputFile);
    Rewrite(Output);
     WriteLn(mx);
     SayRec(mxi);
    Close(Output);
  End;

BEGIN
 Init;
  Solve;
 Done;
END.