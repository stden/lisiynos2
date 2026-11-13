{$APPTYPE CONSOLE}

var
  s,D : string;
  i,C : integer;
  Lex : array [1..100] of string;
begin
  Reset(Input,'money.in');
  Rewrite(Output,'money.out');
  Readln(s);
  {
  C := 1;
  Lex[C] := '';
  for i := 1 to Length(s) do
    case s[i] of
      '0'..'9':
         Lex[C]:=Lex[C]+S[i];
      '*','+': begin
         inc(c);
         Lex[C]:=S[I];
         inc(C);
         Lex[C]:='';
      end;
    end;}
  { }
  for I := 1 to C do
    writeln(I,' ',Lex[I]);
  { Обрабатываем все '+' }

end.
