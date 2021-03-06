(*
 ����� Brackets. ��襭�� ����.
 ��⮭ �������, 2002 ���.
*)

Var
  A : array[1..60001] of Char; {�⥪}
  Top : LongInt; {�����⥫� �� ���設� �⥪� - ����� ��᫥����� �������}
  Ch : Char; {������ �� 䠩��}
  Ok : Boolean;

Begin
  Assign(input, 'b5.in'); ReSet(input);
  Assign(output, 'b5.out'); ReWrite(output);

  Top := 0;
  While not EOF(input) do Begin

    Read(Ch);

    Case Ch of
      '(', '[', '{' : Begin {������塞 � �⥪}
        Inc(Top); A[Top] := Ch;
        if Top > 60000 then Begin
          {�⥪ ���⮫쪮 �����, �� ������ 㦥 �� �ᯥ��}
          WriteLn('NO'); Close(input); Close(output); Halt;
        end;
      end;
      ')', ']', '}' : Begin {�⭨���� �� �⥪�}
        if Top < 1 then Begin
          {����⪠ �⥭�� �� ���⮣� �⥪�}
          WriteLn('NO'); Close(input); Close(output); Halt;
        end;

        {���.: �⥪ �� ���⮩}
        Ok := True;
        if (Ch = ')') and (A[Top] <> '(') then Ok := False;
        if (Ch = ']') and (A[Top] <> '[') then Ok := False;
        if (Ch = '}') and (A[Top] <> '{') then Ok := False;
        if not Ok then Begin
          {��ᮮ⢥��⢨� ᪮���}
          WriteLn('NO'); Close(input); Close(output); Halt;
        end;
        Dec(Top);
      end;
    end;

  end;

  if Top = 0 then Begin
    {�� �諮��}
    WriteLn('YES'); Close(input); Close(output); Halt;
  end;

  {�� �諮��}
  WriteLn('NO'); Close(input); Close(output); Halt;
End.