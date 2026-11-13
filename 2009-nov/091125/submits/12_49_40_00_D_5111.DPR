{ Решение задач D,E }
Var S:String;
    I,N,Sum,Cnt,J:LongInt; { I - Номер требуемой цифры }
      { N - Номер текущей последовательности }
      { Cnt - Количество цифр в текущей последовательности }
      { Sum - Всего цифр в предыдущий последовательностях }
Begin
  Assign(Input,'D.IN'); Reset(Input);
  Assign(Output,'D.OUT'); Rewrite(Output);
  Read(I);
 { Ищем подпоследовательность и позицию в ней }
  Sum:=0; Cnt:=0;
  For N:=1 to MaxLongInt do
    Begin
      Str(N,S); { Приписываем к предыдущей последовательности N }
      Cnt:=Cnt+Length(S); { Длина послед. возрастает на Length(S) }
      If Sum>=(I-Cnt) then Break;
      Sum:=Sum+Cnt;
    End;
  I:=I-Sum; { Теперь I - индекс цифры в текущей подпоследовательности }
 { Ищем цифру в подпоследовательности }
  Cnt:=0;
  For N:=1 to MaxLongInt do
    Begin
      Str(N,S);
      If Cnt>=(I-Length(S)) then Break;
      Cnt:=Cnt+Length(S);
    End;
  I:=I-Cnt; { Теперь I - индекс в текущем числе }
 { Вывод ответа }
  Writeln(S[I]);
End.