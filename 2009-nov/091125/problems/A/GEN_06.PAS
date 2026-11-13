{$APPTYPE CONSOLE}
(*
 Генератор 6-го теста для задачи "Повторные числа"
*)

Var
  f, f1, f2 : text;
  n, i, Rnd : LongInt;

Begin
  Assign(f, '06.'); ReWrite(f);
  Assign(f1, '06.b'); ReWrite(f1);
  Assign(f2, '06.a'); ReWrite(f2);

  for n := 1 to 5 do Begin
    WriteLn(f, '199999');
    for i := 1 to 99999 do Begin
      Rnd := Random(MaxInt);
      Write(f, Rnd, ' ');
      Write(f1, Rnd, ' ');
    end;
    Rnd := Random(MaxInt);
    Write(f, Rnd, ' ');
    WriteLn(f2, Rnd, ' ');
  
    Close(f1); ReSet(f1);
    for i := 1 to 99999 do Begin Read(f1, Rnd); Write(f, Rnd, ' '); end;
    WriteLn(f); Close(f1); ReWrite(f1);
  end;
  WriteLn(f, '0');

  Close(f); Close(f1); Erase(f1); Close(f2);
End.