{ ��襭�� ����� B }
Var Cur:LongInt;
    A : Array [1..60002] of Char;
    C,Para : Char;
Begin
  Assign(Input,'B.IN'); Reset(Input);
  Assign(Output,'B.OUT'); Rewrite(Output);
  Cur:=0; { Cur = ���設� �⥪� }
  Repeat
    Read(C);
    Case C of
      '(','{','[': Begin Inc(Cur); A[Cur]:=C; End;
      ')','}',']': Begin
          If Cur = 0 then Begin Writeln('NO'); Exit; End;
          Case C of
            ')': Para:='(';
            '}': Para:='{';
            ']': Para:='[';
          End;
          If A[Cur]<>Para(C) then Begin Writeln('NO'); Exit; End; 
          Dec(Cur);
        End;
    End;
   { �᫨ ���뢠��� ᪮��� ᫨誮� ����� (㦥 �� ����� ���� �⮫쪮 ����뢠���) }
    If Cur=60002 then Begin Writeln('NO'); Exit; End; 
  Until EOF(Input);
  If Cur<>0 then Begin Writeln('NO'); Exit; End;
  Writeln('YES');
End.