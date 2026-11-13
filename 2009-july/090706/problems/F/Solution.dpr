Const
  MaxP=40;
Type
  TFactoring=Record
    NP:LongInt;
    P:Array[1..MaxP]Of LongInt;
    D:Array[1..MaxP]Of LongInt;
  End;
Var
  I,A,N,Small:LongInt;
  F,F1,F2,F3,F4:TFactoring;
  Ok:Boolean;
Procedure Factor(What:LongInt; Var F:TFactoring);
Var
  I:LongInt;
Begin
  I:=2;
  F.NP:=0;
  While I*I<=What Do Begin
    If What Mod I=0 Then Begin
      Inc(F.NP);
      F.P[F.NP]:=I;
      F.D[F.NP]:=0;
      While What Mod I=0 Do Begin
        What:=What Div I;
        Inc(F.D[F.NP]);
      End;
    End;
    Inc(I);
  End;
  If What>1 Then Begin
    Inc(F.NP);
    F.P[F.NP]:=What;
    F.D[F.NP]:=1;
  End;
End;
Function Min(A,B:LongInt):LongInt;
Begin
  If A<B Then
    Min:=A
  Else
    Min:=B;
End;
Procedure MulFactorings(Const A,B:TFactoring; Var C:TFactoring);
Var
  IA,IB:LongInt;
Begin
  IA:=1;
  IB:=1;
  C.NP:=0;
  While (IA<=A.NP) Or (IB<=B.NP) Do Begin
    If IA>A.NP Then Begin
      Inc(C.NP);
      C.P[C.NP]:=B.P[IB];
      C.D[C.NP]:=B.D[IB];
      Inc(IB);
    End Else If IB>B.NP Then Begin
      Inc(C.NP);
      C.P[C.NP]:=A.P[IA];
      C.D[C.NP]:=A.D[IA];
      Inc(IA);
    End Else Begin
      Inc(C.NP);
      C.P[C.NP]:=Min(A.P[IA],B.P[IB]);
      C.D[C.NP]:=0;
      If C.P[C.NP]=A.P[IA] Then Begin
        Inc(C.D[C.NP],A.D[IA]);
        Inc(IA);
      End;
      If C.P[C.NP]=B.P[IB] Then Begin
        Inc(C.D[C.NP],B.D[IB]);
        Inc(IB);
      End;
    End;
  End;
End;
Begin
  Assign(Input,'f.in');
  ReSet(Input);
  Read(A);
  Close(Input);
  Factor(A,F);
  N:=1;
  For I:=1 To F.NP Do N:=N*F.P[I];
  Factor(N,F1);
  Small:=1;
  Repeat
    Factor(Small,F2);
    MulFactorings(F1,F2,F3);
    For I:=1 To F3.NP Do
      F3.D[I]:=F3.D[I]*(-N*Small);
    MulFactorings(F3,F,F4);
    Ok:=True;
    For I:=1 To F4.NP Do
      If F4.D[I]>0 Then Ok:=False;
    If Ok Then Break;
    Inc(Small);
  Until False;
  Assign(Output,'f.out');
  ReWrite(Output);
  WriteLn(N*Small);
  Close(Output);
End.

