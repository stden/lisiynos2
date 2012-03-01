(*
 Задача Brackets. Решение Автора.
 Антон Попович, 2002 год.
*)

Var
  A : array[1..60001] of Char; {Стек}
  Top : LongInt; {Указатель на вершину стека - номер последнего элемента}
  Ch : Char; {Символ из файла}
  Ok : Boolean;

Begin
  Assign(input, 'b5.in'); ReSet(input);
  Assign(output, 'b5.out'); ReWrite(output);

  Top := 0;
  While not EOF(input) do Begin

    Read(Ch);

    Case Ch of
      '(', '[', '{' : Begin {Добавляем в стек}
        Inc(Top); A[Top] := Ch;
        if Top > 60000 then Begin
          {Стек настолько полный, что прочитать уже не успеть}
          WriteLn('NO'); Close(input); Close(output); Halt;
        end;
      end;
      ')', ']', '}' : Begin {Отнимаем из стека}
        if Top < 1 then Begin
          {Попытка чтения из пустого стека}
          WriteLn('NO'); Close(input); Close(output); Halt;
        end;

        {инв.: стек не пустой}
        Ok := True;
        if (Ch = ')') and (A[Top] <> '(') then Ok := False;
        if (Ch = ']') and (A[Top] <> '[') then Ok := False;
        if (Ch = '}') and (A[Top] <> '{') then Ok := False;
        if not Ok then Begin
          {Несоответствие скобок}
          WriteLn('NO'); Close(input); Close(output); Halt;
        end;
        Dec(Top);
      end;
    end;

  end;

  if Top = 0 then Begin
    {Все сошлось}
    WriteLn('YES'); Close(input); Close(output); Halt;
  end;

  {Не сошлось}
  WriteLn('NO'); Close(input); Close(output); Halt;
End.