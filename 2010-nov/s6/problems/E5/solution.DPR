{ Решение задачи E }
Type TNum = Array [-1..160002] of Integer;
     PNum = ^TNum;
Procedure ReadNum( O:PNum );
  Var I,Num:LongInt; C:Char; Err,Buf:Integer;
  Begin
    Num:=0;
    Repeat Read(C); Until ((C>='0') And (C<='9'));
    Repeat Inc(Num); Val(C,O^[Num],Err); Read(C); Until ((C<'0') Or (C>'9'));
    For I:=1 to (Num div 2) do
      Begin Buf:=O^[I]; O^[I]:=O^[Num-I+1]; O^[Num-I+1]:=Buf; End;
  End;
Var I,Q:LongInt;
    Op1,Op2,Sum:PNum; Out:Boolean;
Begin
  Assign(Input,'E5.IN'); Reset(Input);
  Assign(Output,'E5.OUT'); Rewrite(Output); 
  New(Op1); New(Op2); New(Sum);
  For I:=1 to 70002 do Begin Op1^[I]:=0; Op2^[I]:=0; Sum^[I]:=0; End;
  ReadNum(Op1);
  ReadNum(Op2);
  For I:=1 to 70001 do
    Begin
      Q := Sum^[I]+Op1^[I]+Op2^[I];
      Sum^[I]:= Q mod 10;
      Sum^[I+1]:= Sum^[I+1] + Q div 10;
    End;
  Out:=False;
  For I:=70002 downto 2 do
    Case Sum^[I] of
      0: If Out then Write(Sum^[I]);
      1..9: Begin Out:=True; Write(Sum^[I]); End;
    End;
  Writeln(Sum^[1]);
End.