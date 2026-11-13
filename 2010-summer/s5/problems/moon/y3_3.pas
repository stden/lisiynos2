{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 65520,0,655360}
Const
  MaxN=500;
Var
  K:Array[0..MaxN]Of Record X,Y,R:LongInt; End;
  N:Word;
  M:Array[0..MaxN,0..(MaxN-1) Div 8]Of Byte;
  Max:Array[0..MaxN]Of Word;
  Prev:Array[0..MaxN]Of LongInt;
Function IsIn(A,B:Word):Boolean;
Begin
  IsIn:=M[A,B Shr 3] And (1 Shl (B And 7))>0;
End;
Procedure Load;
Var
  I,J:Word;
Begin
  Assign(Input,'INPUT.TXT');
  ReSet(Input);
  ReadLn(N);
  For I:=1 To N Do ReadLn(K[I].X,K[I].Y,K[I].R);
  Close(Input);
  FillChar(M,SizeOf(M),0);
  K[0].X:=0;
  K[0].Y:=0;
  K[0].R:=MaxLongInt;
  For I:=0 To N Do
    For J:=0 To N Do If I<>J Then Begin
      If Sqrt(1.0*(K[J].X-K[I].X)*(K[J].X-K[I].X)+1.0*(K[J].Y-K[I].Y)*(K[J].Y-K[I].Y))+K[I].R<K[J].R+1E-5 Then Begin
        Inc(M[I,J Shr 3],(1 Shl (J And 7)));
      End;
    End;
End;
Procedure Run;
Function FindIn(A:Word):Word;
Var
  I,V:Word;
Begin
  If Max[A]=0 Then Begin
    Max[A]:=1;
    Prev[A]:=-1;
    For I:=1 To N Do If IsIn(I,A) Then Begin
      V:=FindIn(I)+1;
      If V>Max[A] Then Begin Max[A]:=V; Prev[A]:=I; End;
    End;
  End;
  FindIn:=Max[A];
End;
Begin
  FillChar(Max,SizeOf(Max),0);
  FindIn(0);
End;
Procedure Save;
Var
  F:Boolean;
Procedure Otkat(A:LongInt);
Begin
  A:=Prev[A];
  If A>=0 Then Begin
    Otkat(A);
    If F Then F:=False Else Write(' ');
    Write(A);
  End;
End;
Begin
  Assign(Output,'OUTPUT.TXT');
  ReWrite(Output);
  WriteLn(Max[0]-1);
  F:=True;
  Otkat(0);
  Close(Output);
End;
Begin
  Load;
  Run;
  Save;
End.