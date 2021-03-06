(*
 ����� Numbers. ��襭�� ����.
 ��⮭ �������, 2002 ���.
*)

Var
  Num : LongInt; {������⢮ �ᥫ � ������ �����}

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
  Assign(input, 'a.in'); ReSet(input);
  Assign(output, 'a.out'); ReWrite(output);

  Repeat
    Read(Num); {��⠥� ������⢮ �ᥫ}
    Solution(Num); {��蠥�}
  Until Num = 0;

  Close(input); Close(output);
End.