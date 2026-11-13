uses
  SysUtils;

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


Var I,N : Integer;
    D : Array [1..1000] of Long;
Begin
  Assign(Input,'B3.in'); Reset(Input);
  Assign(Output,'B3.out'); Rewrite(Output);
  D[1]:=ToLong(1);
  D[2]:=ToLong(2);
  D[3]:=ToLong(4);
  Readln(N);
  For I:=4 to N do 
    D[I]:=Add_Abs( Add_Abs(D[I-1],D[I-2]), D[I-3] );
  Writeln(ToString(D[N]))
End.
