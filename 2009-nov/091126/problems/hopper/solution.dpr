Type
  Integer=LongInt;
Const
  TaskID='hopper';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
Var
  S,Res:Integer;
  X,Y,DX,DY:Integer;
Function Load:Boolean;
Begin
  Load:=False;
  Read(S,X,Y,DX,DY);
  If S=0 Then Exit;
  Load:=True;
End;
Procedure Solve;
Begin
  Res:=0;
  While (Res<2*S) And ((X Mod S=0) Or (Y Mod S=0) Or (Not Odd(X Div S+Y Div S))) Do Begin
    Inc(Res);
    X:=X+DX;
    Y:=Y+DY;
  End;
End;
Procedure Save;
Begin
  If Res<2*S Then
    WriteLn(Res)
  Else
    WriteLn(-1);
End;
Begin
  Assign(Input,InFile);
  ReSet(Input);
  Assign(Output,OutFile);
  ReWrite(Output);
  While Load Do Begin
    Solve;
    Save;
  End;
  Close(Input);
  Close(Output);
End.
