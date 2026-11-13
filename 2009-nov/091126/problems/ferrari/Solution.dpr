{$APPTYPE CONSOLE}
Type
  Integer=LongInt;
Const
  TaskID='ferrari';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxK=42;
  MaxN=802;
Type
  PList=^TList;
  TList=Record
    Dest:Integer;
    Length:Integer;
    Next:PList;
  End;
Var
  K,N,M:Integer;
  Edge:Array[1..MaxN]Of PList;
  NumFix:Array[1..MaxN]Of Integer;
  Path:Array[1..MaxN,1..MaxK]Of Integer;
  Res:Integer;
Procedure Load;
Var
  I,A,B,T:Integer;
  P:PList;
Begin
  Read(K,N,M);
  FillChar(Edge,SizeOf(Edge),0);
  For I:=1 To M Do Begin
    Read(A,B,T);
    New(P);
    P^.Dest:=B;
    P^.Length:=T;
    P^.Next:=Edge[A];
    Edge[A]:=P;
    New(P);
    P^.Dest:=A;
    P^.Length:=T;
    P^.Next:=Edge[B];
    Edge[B]:=P;
  End;
End;
Procedure RegNewPath(Where:Integer; Len:Integer);
Var
  I:Integer;
Begin
  If (NumFix[Where]>=K) Or (Path[Where,K]<=Len) Then Exit;
  For I:=K-1 DownTo 0 Do Begin
    If I=0 Then Break;
    If Path[Where,I]<=Len Then Break;
    Path[Where,I+1]:=Path[Where,I];
  End;
  Path[Where,I+1]:=Len;
End;
Procedure Solve;
Var
  I,Best,BestI,CLen:Integer;
  P:PList;
Begin
  FillChar(NumFix,SizeOf(NumFix),0);
  FillChar(Path,SizeOf(Path),127);
  Path[1,1]:=0;
  While NumFix[N]<K Do Begin
    Best:=MaxLongInt Div 2;
    For I:=1 To N Do If NumFix[I]<K Then
      If Path[I,NumFix[I]+1]<Best Then Begin
        Best:=Path[I,NumFix[I]+1];
        BestI:=I;
      End;
    Inc(NumFix[BestI]);
    CLen:=Path[BestI,NumFix[BestI]];
    If BestI<N Then Begin
      P:=Edge[BestI];
      While P<>Nil Do Begin
        RegNewPath(P^.Dest,CLen+P^.Length);
        P:=P^.Next;
      End;
    End;
  End;
  Res:=0;
  For I:=1 To K Do Inc(Res,Path[N,I]);
End;
Procedure Save;
Begin
  WriteLn(Res);
End;
Begin
  Assign(Input,InFile);
  ReSet(Input);
  Assign(Output,OutFile);
  ReWrite(Output);
  Load;
  Solve;
  Save;
  Close(Input);
  Close(Output);
End.
