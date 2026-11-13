{$APPTYPE CONSOLE}

uses
  SysUtils;

// Самая простая знаковая длинная целая арифметика

Const
  MaxLen = 3000; { Максимальная длина длинного числа }

var
  Base: Integer = 10; // База (можно устанавить в начале программы)

Type
  Long = array [0 .. MaxLen] of Integer;

function Digit(Dig: Integer): Char;
begin
  case Dig of
    0 .. 9:
      Result := Chr(Ord('0') + Dig);
    10 .. 35:
      Result := Chr(Ord('A') + Dig - 10);
  else
    raise EOverflow.Create('Слишком большая цифра. Не знаю как выводить ;)');
  end;
end;

function ToLong(N: Int64): Long;
var
  i: Integer;
begin
  fillChar(Result, sizeOf(Result), 0);
  i := 0;
  while N > 0 do
  begin
    Result[i] := N mod Base;
    N := N div Base;
    inc(i);
  end;
end;

// Реальная длина числа = Len + 1 !!!
function Len(Var L: Long): Integer;
begin
  Result := MaxLen;
  while (L[Result] = 0) and (Result > 0) do
    dec(Result);
end;

function ToString(Var L: Long): String;
var
  i: Integer;
begin
  for i := Len(L) downto 0 do
    Result := Result + Digit(L[i]);
end;

procedure FixUp(Var L: Long);
var
  i: Integer;
begin
  for i := 0 to MaxLen - 1 do
  begin
    inc(L[i + 1], L[i] div Base);
    L[i] := L[i] mod Base;
  end;
end;

function Add_Abs(A, b: Long): Long;
var
  i: Integer;
begin
  for i := 0 to MaxLen do
    Result[i] := A[i] + b[i];
  FixUp(Result);
end;

Const MaxN = 1000;

var
  A: array [1..MaxN] of Long;
  N, i: Integer;
begin
  assign(input, 'a3.in');  reset(input);
  assign(output, 'a3.out'); rewrite(output);
  read(N);
  assert( (1 <= N) and (N <= MaxN) ); { Проверяем корректность входного файла }
  A[1] := ToLong(1);
  A[2] := ToLong(1);
  for i := 3 to N do
    A[i] := Add_Abs(A[i - 2], A[i - 1]);
  write(ToString(A[N]));
  close(input);
  close(output);
end.
