(*
 Генератор 13-го теста для задачи "Калькулятор Z-1"
*)

Var
  i, j : longint;

Begin
  Assign(output, '13.'); ReWrite(output);

  for j := 1 to 2 do Begin
    for i := 1 to 60000 do Begin
      Write(Random(10));
    end;
    WriteLn;
  end;

  Close(output);
End.