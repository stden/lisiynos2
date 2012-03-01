{$O+,R-}
{$DEFINE TEST}

unit longArUnit;

interface

uses SysUtils;

// Самая простая знаковая длинная целая арифметика

Const
  MaxLen = 128; { Максимальная длина длинного числа }

var
  Base : Integer = 10; // База (можно устанавить в начале программы)

Type Long = array [-1..MaxLen] of Integer;
  { В -1ой позиции находится знак }
  {  -1 - отрицательное }
  {  +1 - положительное }
  {   0 - ноль :) }

// Инициализация
function ToLong( N:Int64 ):Long; overload;
// Только для десятичной записи
function ToLong( N:String ):Long; overload;
// В Int64
function ToInt( L:Long ):Int64;
// В строку
function ToString( Var L:Long ):String;
// Равные числа
function isEqual( var A,B:Long ):boolean;
// Больще или нет по модулю (если A=B => true)
function isGreatEq_Abs( A,B:Long; Sdvig_B:Integer=0 ):boolean;
// Больще или нет (если A=B => true)
function isGreatEq( A,B:Long ):boolean; { Больше ли A B }
// Сложение длинных
function Add( A,B:Long ):Long;
// Вычитание длинных
function Sub( A,B:Long ):Long;
// Умножение длинных
function Mul( A,B:Long ):Long;
// Возведение в квадрат
function Sqr( A:Long ):Long;
// Деление длинных
function LDiv( A,B:Long ):Long;
// Взять по модулю
function LMod( A,B:Long ):Long;
// Сложение длинного и короткого
function LAdd_Small_Abs( A:Long; B:Int64 ):Long;
// Вычитание из длинного короткого
function LSub_Small_Abs( A:Long; B:Int64 ):Long;
// Умножение длинного на короткое
function LMul_Small_Abs( A:Long; B:Int64 ):Long;
// Длинное по модулю короткого
function LMod_Small( A:Long; B:Int64 ):Int64;
procedure LFactorial( N:Integer; Var L:Long );
function factorial_small( N:Integer ):Int64;
function factorial_big( N:Integer ):Int64;
// Является ли простым число типа Int64?
function is_prime( p:Int64 ):boolean;
// Вычисление НОД двух чисел
function NOD( p,q:int64 ):int64;
// Расширенный алгоритм Евклида
procedure Euklid( p,q:int64; var a,b:int64 );
// Быстрое возведение в степень по Индийской методике
function Fast_mul( a,b,m:Int64 ):Int64;
// Быстрое возведение в степень по Индийской методике (длинные числа)
function LFast_mul( a,b,m:Long ):Long;
// Возвращает случайное число типа Int64
function RandomInt64( max : Int64 ):Int64;

function HexToLong( hex:string ):Long;

var
  MaxHash : Integer = 1000;

type myInt = Integer;

function CalcHash( myText:String ):myInt;
function LCalcHash( myText:String; MaxHash:Long ):Long;

implementation

function Digit( Dig:Integer ):Char;
begin
  case Dig of
    0..9: Result := Chr(Ord('0')+Dig);
    10..35: Result := Chr(Ord('A')+Dig-10);
  else
    raise EOverflow.Create('Слишком большая цифра. Не знаю как выводить ;)');
  end;
end;

function ToLong( N:Int64 ):Long;
var i : integer;
begin
  fillChar(Result,sizeOf(Result),0);
  { Знак }
  if N=0 then Result[-1]:=0
  else if N>0 then Result[-1]:=1
  else begin Result[-1] := -1; N := -N ; end;
  i := 0;
  while N > 0 do begin
    Result[i] := N mod Base;
    N := N div Base;
    inc(i);
  end;
end;

function ToInt( L:Long ):Int64;
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

// Реальная длина числа = Len + 1 !!!
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

procedure FixZero( Var L:Long );
var
  i : Integer;
  isZero : Boolean;
begin
  isZero := true;
  for i:=0 to MaxLen do
    if L[i]<>0 then begin
      isZero := false;
      break;
    end;
  if isZero then L[-1]:=0;
end;

procedure FixUp( Var L:Long );
var i : Integer;
begin
  for i:=0 to MaxLen-1 do begin
    inc( L[i+1], L[i] div Base );
    L[i] := L[i] mod Base;
  end;
  FixZero(L);
end;

procedure FixDown( Var L:Long );
var i : Integer;
begin
  for i:=0 to MaxLen-1 do
    while L[i] < 0 do begin
      inc( L[i], Base );
      dec( L[i+1], 1 );
    end;
  FixZero(L);
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

function Add_Abs( A,B:Long ):Long;
var i : Integer;
begin
  for i:=0 to MaxLen do Result[i] := A[i] + B[i];
  FixUp(Result);
end;

function Sub_Abs( A,B:Long; Sdvig_B:Integer=0 ):Long;
var i : Integer;
begin
  assert( isGreatEq_Abs(A,B) );
  for i:=0 to Sdvig_B-1 do Result[i] := A[i];
  for i:=Sdvig_B to MaxLen do Result[i] := A[i] - B[i-Sdvig_B];
  FixDown(Result);
end;

function Add( A,B:Long ):Long;
begin
  { Рассмотрим 2 случая: }
  if A[-1] = B[-1] then begin { A и B одного знака }
    Result := Add_Abs(A,B);
    Result[-1] := A[-1]; { Тогда знак их суммы такой же как у A и B }
  end else begin { A и B с разными знаками }
    { Тогда знак суммы равен знаку наибольшего из них по абсолютному значению,
      а значение - разности абсолютных значений }
    if isGreatEq_Abs(A,B) then begin
      REsult := Sub_Abs(A,B); { Если A больше по абсолютному значению - вычитаем из A B }
      Result[-1] := A[-1];
    end else begin { иначе из B A }
      Result := Sub_Abs(B,A);
      Result[-1] := B[-1];
    end;
  end;
end;

function Sub( A,B:Long ):Long;
begin
  B[-1] := -B[-1]; { Изменяем знак и складываем }
  Result := Add(A,B);
end;

function Mul( A,B:Long ):Long;
var i,j : Integer;
begin
  fillChar(Result,sizeOf(Result),0);
  for i:=0 to MaxLen do
    for j:=0 to MaxLen-i do
      Inc( Result[i+j], A[i]*B[j] );
  Result[-1] := A[-1] * B[-1]; { Знаки перемножаются }
  FixUp(Result);
end;

// Возведение в квадрат
function Sqr( A:Long ):Long;
begin
  Result := Mul(A,A);
end;

function LDiv( A,B:Long ):Long;
var Sdvig_B : Integer;
begin
  fillChar(Result,sizeOf(Result),0);
  Result[-1] := A[-1] * B[-1]; { Знаки перемножаются }    
  for Sdvig_B:=Len(A)-Len(B) downto 0 do
    while isGreatEq_Abs(A,B,Sdvig_B) do begin
      A := Sub_Abs(A,B,Sdvig_B);
      Inc( Result[Sdvig_B] );
    end;
  FixUp(Result);
end;

function LMod( A,B:Long ):Long;
var Sdvig_B : Integer;
begin
  for Sdvig_B:=Len(A)-Len(B) downto 0 do
    while isGreatEq_Abs(A,B,Sdvig_B) do
      A := Sub_Abs(A,B,Sdvig_B);
  Result := A;
  Result[-1] := 1;
end;

function LAdd_Small_Abs( A:Long; B:Int64 ):Long;
begin
  Result:=A;
  if (Result[-1]=0) and (B>0) then Result[-1]:=1;
  Inc( Result[0], B );
  FixUp(Result);
end;

function LSub_Small_Abs( A:Long; B:Int64 ):Long;
begin
  Result:=A;
  Result[-1] := 1;
  Dec( Result[0], B );
  FixDown(Result);
end;

function LMul_Small_Abs( A:Long; B:Int64 ):Long;
var i : Integer;
begin
  Result[-1] := A[-1];
  for i:=0 to MaxLen do
    Result[i] := A[i] * B;
  FixUp(Result);
end;

function LMod_Small( A:Long; B:Int64 ):Int64;
var i : Integer;
begin
  Result := 0;
  for i:=MaxLen downto 0 do
    Result := (Result * Base + A[i]) mod B;
end;

procedure LFactorial( N:Integer; Var L:Long );
var
  i : Integer;
begin
  L := ToLong(1);
  for i:=1 to N do
    L := LMul_Small_Abs(L,i);
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

function is_prime( p:Int64 ):boolean;
var i : Int64;
begin
  Result := false;
  if p<=1 then exit;
  i:=2;
  while i*i<=p do begin
    if p mod i = 0 then exit;
    inc( i );
  end;
  Result := true;
end;

function NOD( p,q:int64 ):int64;
begin
  while ((p<>0) and (q<>0)) do
    if p > q then
      p := p mod q
    else
      q := q mod p;
  if q<>0 then
    Result := q
  else
    Result := p;
end;

procedure Euklid( p,q:int64; var a,b:int64 );
var
  pp, qq : array [1..2] of int64;
  d : int64;
begin
  assert( NOD(p,q) = 1 );
  pp[1]:= 1; pp[2] := 0;
  qq[1]:= 0; qq[2] := 1;
  while ((p<>0) and (q<>0)) do
    if p > q then begin
      d := p div q;
      assert( p - d*q = p mod q );
      p := p - d*q;
      pp[1] := pp[1] - d*qq[1];
      pp[2] := pp[2] - d*qq[2];
    end else begin
      d := q div p;
      assert( q - d*p = q mod p );
      q := q - d*p;
      qq[1] := qq[1] - d*pp[1];
      qq[2] := qq[2] - d*pp[2];
    end;
  if q<>0 then begin
    a := qq[1]; b := qq[2];
  end else begin
    a := pp[1]; b := pp[2];
  end;
end;

function fast_mul( a,b,m:Int64 ):Int64;
begin
  if b = 0 then
    Result := 1
  else
    case b mod 2 of
      0: begin
           Result := fast_mul(a,b div 2,m);
           Result := Result*Result;
         end;
      1: Result := (fast_mul(a,b-1,m) * a);
    end;
  Result := Result mod m;
end;

// Быстрое возведение в степень по Индийской методике (длинные числа)
function LFast_mul( a,b,m:Long ):Long;
var
  LZero:Long;
begin
  LZero := ToLong(0);
  if IsEqual(b,LZero) then
    Result := ToLong(1)
  else
    case LMod_Small(b,2) of
      0: begin
           Result := LFast_mul(a,LDiv(B,ToLong(2)),m);
           Result := Sqr(Result);
         end;
      1: Result := Mul( LFast_mul(a,LSub_Small_Abs(b,1),m), a );
    end;
  Result := LMod( Result, m );
end;

function RandomInt64( max : Int64 ):Int64;
begin
  Result := Random(maxLongint) * (High(Int64) div Int64(maxLongint));
  Result := Result + Random(maxLongint);
  Result := Result mod max;
end;

function CalcHash( myText:String ):myInt;
var i:integer;
begin
  Result := 19;
  for i:=1 to Length(myText) do
    if odd(i) then
      Result := (Result*13 + ord(myText[i])) mod MaxHash
    else
      Result := (Result*17 + ord(myText[i])) mod MaxHash;
end;

function LCalcHash( myText:String; MaxHash:Long ):Long;
var i:integer;
begin
  Result := ToLong(19);
  for i:=1 to Length(myText) do
    if not odd(i) then
      Result := LMod(LAdd_Small_Abs(LMul_Small_Abs(Result,13),ord(myText[i])),MaxHash)
    else
      Result := LMod(LAdd_Small_Abs(LMul_Small_Abs(Result,17),ord(myText[i])),MaxHash);
end;

function isEqual( var A,B:Long ):boolean;
begin
  Result := CompareMem(@A,@B,sizeOf(Long));
end;

// Только для десятичной записи
function ToLong( N:String ):Long; overload;
var i:Integer;
begin
  fillChar(Result,sizeOf(Result),0);
  if N[1]='-' then begin
    Result[-1] := -1;
    Delete(N,1,1);
  end else if N='0' then
      Result[-1] := 0
  else
    Result[-1] := +1;
  for i:=1 to Length(N) do
    Result[Length(N)-i] := Ord(N[i])-Ord('0');
end;

function Conv( HexDigit:Char ):Integer;
begin
  if HexDigit in ['0'..'9'] then begin
    Result := Ord(HexDigit) - Ord('0');
    exit;
  end;
  if HexDigit in ['A'..'F'] then begin
    Result := Ord(HexDigit) - Ord('A') + 10;
    exit;
  end;
end;

function HexToLong( hex:string ):Long;
var
  Base,i : Integer;
begin
  Result := ToLong(0);
  Base := 16;
  for i:=1 to Length(hex) do
    Result := Add(LMul_Small_Abs(Result,Base),ToLong(Conv(Hex[i])));
end;

{$IFDEF TEST}
const MaxRandom = 100000000;
var
  i : integer;
  A,B,C,M : int64;
  AA,BB,CC,MM,X,SaveA,SaveB : Long;
  S : String;
begin
  randomize;
  for i:=1 to 2000 do begin
    // Имеем число
    A := Random(MaxRandom) - MaxRandom div 2;
    AA := ToLong(A);
    assert( ToInt(AA) = A ); // Тестируем правильность перевода обратно в десятичную запись
    assert( ToString(AA) = IntToStr(A) ); // Тестируем правильность перевода в строку
    // Проверяем работу процедуры приёма из строки
    S := IntToStr(A);
    assert( ToInt(ToLong(S)) = A );
    // Добавляем второе число
    B := Random(Abs(A)) - Abs(A) div 2;
    BB := ToLong(B);
    // Тестируем сложение
    CC := Add(AA,BB);
    assert( ToInt(CC) = A+B, IntToStr(ToInt(CC)) );
    // Тестируем вычитание
    SaveA := AA; SaveB := BB;
    CC := Sub( AA,BB );
    assert( ToInt(CC) = A-B );
    assert( isEqual(AA,SaveA) );
    assert( isEqual(BB,SaveB) ); // проверяем что мы не испортили первоначальные длинные числа
    // Тестируем умножение
    assert( ToInt(Mul(AA,BB)) = A*B );
    // Тестируем сравнение
    assert( isGreatEq(AA,BB) = (A >= B), 'A='+IntToStr(A)+' B='+IntToStr(B)  );
    assert( isGreatEq(AA,AA) = true );
    // Тестируем деление и получение модуля
    if (A>0) and (B>1) then begin
      assert( ToInt(LDiv(AA,BB)) = A div B );
      assert( ToInt(LMod(AA,BB)) = A mod B );
    end;
  end;
  // Операции между длинным и коротким числом
  // (!!!) Библиотека работает только для положительных чисел (!!!)
  for i:=1 to 2000 do begin
    // Генерируем длинное число
    A := Random(10000);
    AA := ToLong(A);
    // Генерируем короткое число
    B := Random(A)+1;
    // Сложение длинного и короткого
    CC := LAdd_Small_Abs( AA,B );
    assert( ToInt(CC) = A+B, Format('%d+%d=%d',[A,B,ToInt(CC)]) );
    assert( ToString(CC) = IntToStr(A+B) );
    // Вычитание из длинного короткого
    if A >= B then begin
      CC := LSub_Small_Abs(AA,B);
      assert( ToInt(CC) = A-B, IntToStr(ToInt(CC)) );
      assert( ToString(CC) = IntToStr(A-B) );
    end;
    // Умножение длинного на короткое
    CC := LMul_Small_Abs( AA,B );
    assert( ToInt(CC) = A*B, Format('%d*%d = %d (?)', [A,B,ToInt(CC)] ) );
    assert( ToString(CC) = IntToStr(A*B) );
    // Длинное по модулю короткого
    C := LMod_Small(AA,B);
    assert( C = A mod B );
  end;
  // Тестируем длинное быстрое возведение в степень
  for i:=1 to 20 do begin
    A := Random(MaxRandom);
    AA := ToLong(A);
    B := Random(MaxRandom);
    BB := ToLong(B);
    M := Random(MaxRandom);
    MM := ToLong(M);
    X := LFast_mul(AA,BB,MM);
    assert( fast_mul(A,B,M) = ToInt(X) );
  end;
  for i:=1 to 22 do
    assert( factorial_small(i) = factorial_big(i) );
  for i:=1 to 100 do
    LFactorial(i,CC);
{$ENDIF}
end.

