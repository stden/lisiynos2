program MySol;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  Int = int64;

var
  Answer : string = '0';
  N : integer; { Количество чисел в выражении }
  Chisla : array [1..12] of Int; { Сами числа }
  Znaki : array [1..11] of Char; { Знаки }
  ExpectedResult : Int;

{ Итак, все знаки расставлены, осталось только
  проверить, получается ли результат и запомнить выражение,
  если получается }
procedure CheckResult;
var
  i : integer;
  sum,Mul : Int;
  Znak : char;
begin
  sum := 0;
  i := 1;
  sum := Chisla[1];
  while i < N do begin
    Znak := Znaki[i]; { Запомнили знак }
    { Перемножили числа }
    Mul := Chisla[i+1];
    while (Znaki[i+1]='*') and (i+1 < N) do begin
      Mul := Mul * Chisla[i+2];
      inc(i);
    end;
    { Применили текущий знак }
    case Znak of
      '+': sum := sum + Mul;
      '-': sum := sum - Mul;
      '*': sum := sum * Mul;
    end;
    inc(i);
  end;
  if sum = ExpectedResult then begin
    Answer := IntToStr(Chisla[1]);
    for i := 1 to N-1 do
      Answer := Answer + Znaki[i] + IntToStr(Chisla[i+1]);
  end;
end;

{ Рекурсивный перебор знаков }
{ i - начиная с какого числа }
procedure Calc( i:integer );
begin
  if i = N then begin
    CheckResult;
  end else begin
    Znaki[i]:='*'; Calc(i+1);
    Znaki[i]:='+'; Calc(i+1);
    Znaki[i]:='-'; Calc(i+1);
  end;
end;

procedure ReadData;
var
  i: Integer;
begin
  Reset(input,'a.in');
  Read(ExpectedResult);
  Read(N);
  assert( (1 <= N) and (N <= 12) );
  for i := 1 to N do
    Read(Chisla[i]);
end;

procedure WriteAnswer;
begin
  Rewrite(output,'a.out');
  Writeln(Answer);
//  writeln(5+6+7*10*15-8);
end;

begin
  try
    ReadData;
    Calc(1);
    WriteAnswer;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
