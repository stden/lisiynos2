{
  Решение к задаче D."Строка"
  Автор: Зубарев П.С.
}

{$APPTYPE CONSOLE}

Var i, N, Step : Longint;

Begin
  Assign(input,'d.in');Reset(input);
  Assign(output,'d.out');Rewrite(output);
  Read(N);
  Step:=0;
  While (N mod 2) = 0 do Begin
    Inc(Step);
    N := N shr 1;
  End;
  Write(Chr(Ord('a')+Step));
End.