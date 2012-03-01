{$apptype console}

uses SysUtils;

{ Самая простая знаковая длинная целая арифметика }

Const
  MaxLen = 3000; { Максимальная длина длинного числа }
  Base = 10; { База }

type
  Integer = SmallInt;

function Digit( Dig:Integer ):Char;
begin
  case Dig of
    0..9: Result := Chr(Ord('0')+Dig);
    10..35: Result := Chr(Ord('A')+Dig-10);
  else
    raise EOverflow.Create('Слишком большая цифра. Не знаю как выводить ;)');
  end;
end;

Type Long = array [-1..MaxLen] of Integer;
  { В -1ой позиции находится знак }
  {  -1 - отрицательное }
  {  +1 - положительное }
  {   0 - ноль :) }

procedure Init( Var L:Long; N:Int64 );
var i : integer;
begin
  fillChar(L,sizeOf(L),0);
  { Знак }
  if N=0 then L[-1]:=0
  else if N>0 then L[-1]:=1
  else begin L[-1] := -1; N := -N ; end;
  i := 0;
  while N > 0 do begin
    L[i] := N mod Base;
    N := N div Base;
    inc(i);
  end;
end;

function ToInt( Var L:Long ):Int64;
var
  i : Integer;
  X : Int64;
begin
  X := 1;
  Result := 0;
  for i:=0 to MaxLen do begin
    assert( L[i] >= 0 );
    Inc( Result, X*L[i] );
    X := X * Base;
  end;
  Result := Result * L[-1];
end;

{ Реальная длина числа = Len + 1 !!! }
function Len( Var L:Long ):Integer;
begin
  Result:=MaxLen;
  while (L[Result]=0) and (Result>0) do dec(Result);
end;

function ToString( Var L:Long ):String;
var i : Integer;
begin
  Case L[-1] of
    -1: Result := '-';
    0,1: Result := '';
  end;
  for i:=Len(L) downto 0 do
    Result := Result + Digit(L[i]);
end;

procedure FixUp( Var L:Long );
var i : Integer;
begin
  for i:=0 to MaxLen-1 do begin
    inc( L[i+1], L[i] div Base );
    L[i] := L[i] mod Base;
  end;
end;

procedure FixDown( Var L:Long );
var i : Integer;
begin
  for i:=0 to MaxLen-1 do
    while L[i] < 0 do begin
      inc( L[i], Base );
      dec( L[i+1], 1 );
    end;
end;

function isGreatEq_Abs( A,B:Long; Sdvig_B:Integer=0 ):boolean;
var i : Integer;
begin
  for i:=MaxLen-Sdvig_B downto 0 do begin
    if A[i+Sdvig_B]>B[i] then begin Result := true; exit; end;
    if A[i+Sdvig_B]<B[i] then begin Result := false; exit; end;
  end;
  Result := true; { A и B равны }
end;

function isGreatEq( A,B:Long ):boolean; { Больше ли A B }
begin
  case A[-1] of
    -1: case B[-1] of
       -1: Result := isGreatEq_Abs(B,A); { A отрицательно B отрицательно }
        0: Result := false; { A отрицательно B ноль }
       +1: Result := false; { A отрицательно B положительно }
       end;
     0: case B[-1] of
       -1: Result := true; { A ноль B отрицательно }
        0: Result := true; { A ноль B ноль }
       +1: Result := isGreatEq_Abs(A,B); { A ноль B положительно }
       end;
    +1: case B[-1] of
       -1: Result := true; { A положительно B отрицательно }
        0: Result := true; { A положительно B ноль }
       +1: Result := isGreatEq_Abs(A,B); { A положительно B положительно }
       end;
  end;
end;

procedure LAdd_Abs( A,B:Long; Var C:Long );
var i : Integer;
begin
  for i:=0 to MaxLen do C[i] := A[i] + B[i];
  FixUp(C);
end;

procedure LSub_Abs( A,B:Long; Var C:Long; Sdvig_B:Integer=0 );
var i : Integer;
begin
  assert( isGreatEq_Abs(A,B) );
  for i:=0 to Sdvig_B-1 do C[i] := A[i];
  for i:=Sdvig_B to MaxLen do C[i] := A[i] - B[i-Sdvig_B];
  FixDown(C);
end;

procedure LAdd( A,B:Long; Var C:Long );
begin
  { Рассмотрим 2 случая: }
  if A[-1] = B[-1] then begin { A и B одного знака }
    C[-1] := A[-1]; { Тогда знак их суммы такой же как у A и B }
    LAdd_Abs(A,B,C);
  end else begin { A и B с разными знаками }
    { Тогда знак суммы равен знаку наибольшего из них по абсолютному значению,
      а значение - разности абсолютных значений }
    if isGreatEq_Abs(A,B) then begin
      LSub_Abs(A,B,C); { Если A больше по абсолютному значению - вычичтаем из A B }
      C[-1] := A[-1];
    end else begin { иначе из B A }
      LSub_Abs(B,A,C);
      C[-1] := B[-1];
    end;
  end;
end;

procedure LSub( A,B:Long; Var C:Long );
begin
  B[-1] := -B[-1]; { Изменяем знак и складываем }
  LAdd(A,B,C);
end;

procedure LMul( A,B:Long; Var C:Long );
var i,j : Integer;
begin
  fillChar(C,sizeOf(C),0);
  for i:=0 to MaxLen do
    for j:=0 to MaxLen-i do
      Inc( C[i+j], A[i]*B[j] );
  C[-1] := A[-1] * B[-1]; { Знаки перемножаются }
  FixUp(C);
end;

procedure LDiv( A,B:Long; Var C:Long );
var Sdvig_B : Integer;
begin
  fillChar(C,sizeOf(C),0);
  for Sdvig_B:=Len(A)-Len(B) downto 0 do
    while isGreatEq_Abs(A,B,Sdvig_B) do begin
      LSub_Abs(A,B,A,Sdvig_B);
      Inc( C[Sdvig_B] );
    end;
  C[-1] := A[-1] * B[-1]; { Знаки перемножаются }    
  FixUp(C);
end;

procedure LMod( A,B:Long; Var C:Long );
var Sdvig_B : Integer;
begin
  for Sdvig_B:=Len(A)-Len(B) downto 0 do
    while isGreatEq_Abs(A,B,Sdvig_B) do
      LSub_Abs(A,B,A,Sdvig_B);
  C := A;
  C[-1] := 1;
end;

procedure LAdd_Small( A:Long; B:Int64; Var C:Long );
begin
  C:=A;
  Inc( C[0], B );
  FixUp(C);
end;

procedure LSub_Small( A:Long; B:Int64; Var C:Long );
begin
  C:=A;
  Dec( C[0], B );
  FixDown(C);
end;

procedure LMul_Small( A:Long; B:Int64; Var C:Long );
var i : Integer;
begin
  for i:=0 to MaxLen do
    C[i] := A[i] * B;
  FixUp(C);
end;

(*procedure LDiv_Small( A,B:Long; Var C:Long );
var Sdvig_B : Integer;
begin
  fillChar(C,sizeOf(C),0);
  for Sdvig_B:=Len(A)-Len(B) downto 0 do
    while isGreatEq(A,B,Sdvig_B) do begin
      LSub(A,B,A,Sdvig_B);
      Inc( C[Sdvig_B] );
    end;
end;

procedure LMod_Small( A,B:Long; Var C:Long );
var Sdvig_B : Integer;
begin
  for Sdvig_B:=Len(A)-Len(B) downto 0 do
    while isGreatEq(A,B,Sdvig_B) do
      LSub(A,B,A,Sdvig_B);
  C := A;
end; *)

procedure LFactorial( N:Integer; Var L:Long );
var
  i : Integer;
begin
  Init( L, 1 );
  for i:=1 to N do begin
    LMul_Small(L,i,L);
    writeln(i,'!=',ToString(L));
  end;
  writeln(ToString(L));
end;

function factorial_small( N:Integer ):Int64;
var i : Integer;
begin
  Result := 1;
  for i:=1 to N do
    Result := Result * i;
end;

function factorial_big( N:Integer ):Int64;
var
  i : Integer;
  L : Long;
begin
  LFactorial(N,L);
  Result := ToInt(L);
end;

const MaxRandom = 100000000;

var
  i : integer;
  A,B : int64;
  AA,BB,CC,SaveA,SaveB : Long;
begin
  randomize;
  for i:=1 to 20 do begin
    { Имеем число }
    A := Random(MaxRandom) - MaxRandom div 2;
    Init( AA, A );
    assert( ToInt(AA) = A ); { Тестируем правильность перевода обратно в десятичную запись }
    assert( ToString(AA) = IntToStr(A) ); { Тестируем правильность перевода в строку }
    { Добавляем второе число }
    B := Random(Abs(A)) - Abs(A) div 2;
    Init( BB, B );
    LAdd( AA,BB,CC );
    assert( ToInt(CC) = A+B );
    SaveA := AA; SaveB := BB;
    LSub( AA,BB,CC );
    assert( ToInt(CC) = A-B );
//    assert( AA=SaveA ); assert( BB=SaveB ); { проверяем что мы не испортили первоначальные
//      длинные числа }
    LMul( AA,BB,CC );
    assert( ToInt(CC) = A*B );
    assert( isGreatEq(AA,BB) = (A >= B), 'A='+IntToStr(A)+' B='+IntToStr(B)  );
    assert( isGreatEq(AA,AA) = true );
    if (A>0) and (B>1) then begin
      LDiv( AA,BB,CC );
      assert( ToInt(CC) = A div B );
      LMod( AA,BB,CC );
      assert( ToInt(CC) = A mod B );
    end;
  end;
(*  for i:=1 to 22 do
    assert( factorial_small(i) = factorial_big(i) ); *)
  factorial_big(1000);
(*  for i:=1 to 1000 do begin
    LFactorial(i,CC);
    writeln(i,'!=',ToString(CC));
  end; *)
end.
