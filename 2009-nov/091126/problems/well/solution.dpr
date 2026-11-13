Type
  Integer=LongInt;
Const
  TaskID='well';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxG=102;
  MaxD=102;
Var
  D,G:Integer;
  T,F,H:Array[1..MaxG]Of Integer;
  Best:Array[0..1,0..MaxD]Of Integer;
  Res:Integer;
Procedure Load;
Var
  I:Integer;
Begin
  Read(D,G);
  For I:=1 To G Do Read(T[I],F[I],H[I]);
End;
Procedure Solve;
Var
  Cur,Prev,I,J,Tmp,PT,DT:Integer;
Begin
  For I:=1 To G Do
    For J:=G DownTo I+1 Do If T[J-1]>T[J] Then Begin
      Tmp:=T[J-1];
      T[J-1]:=T[J];
      T[J]:=Tmp;
      Tmp:=F[J-1];
      F[J-1]:=F[J];
      F[J]:=Tmp;
      Tmp:=H[J-1];
      H[J-1]:=H[J];
      H[J]:=Tmp;
    End;
  FillChar(Best,SizeOf(Best),255);
  Best[0,0]:=10;
  Cur:=0;
  PT:=0;
  Res:=10;
  For I:=1 To G Do Begin
    Prev:=Cur;
    Cur:=1-Cur;
    FillChar(Best[Cur],SizeOf(Best[Cur]),255);
    DT:=T[I]-PT;
    For J:=0 To D Do Begin
      If Best[Prev,J]>=DT Then Begin
        Best[Cur][J]:=Best[Prev][J]-DT+F[I];
        If T[I]+Best[Cur,J]>Res Then Res:=T[I]+Best[Cur,J];
      End;
      If (J>=H[I]) And (Best[Prev,J-H[I]]>=DT) Then
        If Best[Prev,J-H[I]]-DT>Best[Cur,J] Then Begin
          Best[Cur,J]:=Best[Prev,J-H[I]]-DT;
          If Best[Cur,J]+T[I]>Res Then Res:=T[I]+Best[Cur,J];
        End;
    End;
    If Best[Cur,D]>=0 Then Begin
      Res:=T[I];
      Break;
    End;
    PT:=T[I];
  End;
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
