(*
 Задача Bull. Решение Автора.
 Антон Попович, 2002 год.
*)

Type
  String6 = String[6]; {Вводим тип переменной}

{Процедура, обрабатывающая строку}
procedure Check(var S : String6; var AT, AF, BT, BF, Err : Boolean);
Begin
  {Анализируем первые два значения}
  if S[1] = 'T' then AF := False;
  if S[1] = 'F' then AT := False;
  if S[2] = 'T' then BF := False;
  if S[2] = 'F' then BT := False;

  {Анализируем другие значения}
  if S[3] = 'T' then Begin
    if not AT then Err := True;
    AF := False;
    if not BT then Err := True;
    BF := False;
  end;
  if S[3] = 'F' then Begin
    if not AF and not BF then Err := True;
  end;
  if S[3] = '?' then Begin
    if not AF and not BF then S[3] := 'T';
    if not AT or not BT then S[3] := 'F';
  end;

  if S[4] = 'T' then Begin
    if not AT and not BT then Err := True;
  end;
  if S[4] = 'F' then Begin
    if not AF then Err := True;
    AT := False;
    if not BF then Err := True;
    BT := False;
  end;
  if S[4] = '?' then Begin
    if not AF or not BF then S[4] := 'T';
    if not AT and not BT then S[4] := 'F';
  end;

  if S[5] = 'T' then Begin
    if not (AT and BF) and not (AF and BT) then Err := True;
    if (S[3] = 'T') or (S[4] = 'F') then Err := True;
    if AT and BF and ((not AF) or (not BT)) then Begin AF := False; BT := False; end;
    if AF and BT and ((not AT) or (not BF))  then Begin AT := False; BF := False; end;
  end;
  if S[5] = 'F' then Begin
    if not (AT and BT) and not (AF and BF) then Err := True;
    if (S[3] = 'F') and (S[4] = 'T') then Err := True;
    if AT and BT and ((not AF) or (not BF)) then Begin AF := False; BF := False; end;
    if AF and BF and ((not AT) or (not BT)) then Begin AT := False; BT := False; end;
  end;
  if S[5] = '?' then Begin
    if AT and BF and not AF and not BT then S[5] := 'T';
    if AF and BT and not AT and not BF then S[5] := 'T';
    if AT and BT and not AF and not BF then S[5] := 'F';
    if AF and BF and not AT and not BT then S[5] := 'F';
    if (S[3] = 'T') or (S[4] = 'F') then S[5] := 'F';
    if (S[3] = 'F') and (S[4] = 'T') then S[5] := 'T';
  end;

  if S[6] = 'F' then Begin
    if not AT or not BF then Err := True;
    if S[5] = 'F' then Err := True;
    AF := False; BT := False;
  end;
  if S[6] = 'T' then Begin
    if not AF and not BT then Err := True;
    if AT and not AF then BF := False;
    if BF and not BT then AT := False;
  end;
  if S[6] = '?' then Begin
    if AT and not AF and BF and not BT then S[6] := 'F';
    if AF and not AT then S[6] := 'T';
    if BT and not BF then S[6] := 'T';
    if S[5] = 'F' then S[6] := 'T';
  end;

  {Устанавливаем первые значения}
  if AT and not AF then S[1] := 'T';
  if AF and not AT then S[1] := 'F';
  if BT and not BF then S[2] := 'T';
  if BF and not BT then S[2] := 'F';

end;

procedure Solve;
Var
  S : String6; {Строка из входного файла}

  {Могут ли быть равны соответственно A = True, A = False, B = True, B = False}
  AT, AF, BT, BF : Boolean;
  Err : Boolean; {Содержится ли в таблице ошибка}
Begin
  ReadLn(S);
  AT := True; AF := True; BT := True; BF := True;
  Err := False;

  {Вызываем два прохода по строке}
  Check(S, AT, AF, BT, BF, Err);
  Check(S, AT, AF, BT, BF, Err);

  if Err then S := 'ERROR';

  WriteLn(S);
end;

Var
  i,
  N : LongInt; {Количество строк во входном файле}

Begin
  Assign(input, 'f5.in'); ReSet(input);
  Assign(output, 'f5.out'); ReWrite(output);

  ReadLn(N);
  for i := 1 to N do Solve;

  Close(input); Close(output);
End.