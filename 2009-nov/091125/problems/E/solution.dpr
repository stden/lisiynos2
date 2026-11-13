{ Решение задач D,E }
uses SysUtils;

Var S:String;
    I,K,SK,L:LongInt;
Begin
  Assign(Input,'E.IN'); Reset(Input);
  Assign(Output,'E.OUT'); Rewrite(Output);
  Read(I); { I - Номер требуемой цифры }
 { Ищем подпоследовательность и позицию в ней }
  SK:=0; L:=0;
  for K:=1 to MaxLongInt do begin
    L:=L+Length(IntToStr(K));
    if SK >= I-L then Break;
    SK:=SK+L;
  end;
  I:=I-SK; { Теперь I - индекс цифры в текущей подпоследовательности }
 { Ищем цифру в подпоследовательности }
  L:=0;
  For K:=1 to MaxLongInt do
    Begin
      Str(K,S);
      If L >= I-Length(S) then Break;
      L:=L+Length(S);
    End;
  I:=I-L; { Теперь I - индекс в текущем числе }
 { Вывод ответа }
  Writeln(S[I]);
End.