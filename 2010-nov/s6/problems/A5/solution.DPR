(*
 Задача Numbers. Решение Автора.
 Антон Попович, 2002 год.
*)

Var
  Num : LongInt; {Количество чисел в данной задаче}

procedure Solution(Num : LongInt);
Var
  Res, N, i : LongInt;
Begin
  if Num = 0 then Exit;

  Res := 0;
  for i := 1 to Num do Begin
    Read(N);
    Res := Res xor N;
  end;
  WriteLn(Res);
end;

Begin
  Assign(input, 'repeat.in'); ReSet(input);
  Assign(output, 'repeat.out'); ReWrite(output);

  Repeat
    Read(Num); {Читаем количество чисел}
    Solution(Num); {Решаем}
  Until Num = 0;

  Close(input); Close(output);
End.