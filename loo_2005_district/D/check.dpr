{ Ленинградская областная олимпиада 2004-2005. Районный тур }
{ Задача D. Римская система счисления }
{ Проверяющая программа: Степулёнок Денис - Denis@nic.spb.ru }
{ Язык: Delphi 6.0/7.0 }
{$APPTYPE CONSOLE}
Uses TestLib,SysUtils;

const MaxN = 3000;

var
  C : array ['A'..'Z'] of Longint;
const
  Sym : set of char = ['I','X','C','M','V','L','D'];
  wrong : array [1..6] of string = ( 'VIV', 'LXL', 'DCD', 'VV', 'LL', 'DD' );

Var Test : Integer;

function toDec( S:String ):Integer;
var i,j:Integer;
begin
  { Проверка числа }
  if Length(S) <= 0  then
    QUIT(_PE,Format(' (Строка %d) Пустая строка!',[Test]) );
  for i:=1 to Length(S) do
    if not (S[i] in Sym) then
      QUIT(_PE,Format(' (Строка %d) User = %s сожержит недопустимый символ %c в позиции %d',
        [Test,S,S[i],i]) );
  for i:=1 to Length(S)-3 do
    if ((S[i]=S[i+1]) and (S[i+1]=S[i+2])) then
      if S[i+2] = S[i+3] then
        QUIT(_PE,Format(' (Строка %d) User = %s сожержит 4 одинаковых символа подряд начиная с позиции %d',
          [Test,S,i]) );
  for i:=1 to Length(S) do
    for j:=1 to 6 do
      if Copy(S,i,Length(wrong[j])) = wrong[j] then
        QUIT( _PE, Format(' (Строка %d) %s содержит запрещённую комбинацию %s',
          [Test,S,wrong[j]]) );
  {}
  Result := C[S[Length(S)]];
  for i:=Length(S)-1 downto 1 do begin
    if C[S[i]] >= C[S[i+1]] then
      Result := Result + C[S[i]]
    else
      Result := Result - C[S[i]];
  end;
end;

function toRoman( N:Integer ):String;
var
  Max:Integer;
  ch,mch:Char;
  Last,Prev:String;
begin
  Result := '';
  while N>=1 do begin
    Max := 0;
    for ch:='A' to 'Z' do
      if ((C[ch]<=N) and (C[ch]>max)) then begin
        max := C[ch];
        mch := ch;
      end;
    Last := Copy(Result,Length(Result),1);
    Prev := Copy(Result,1,Length(Result)-1);
    if N div max = 4 then begin
      case mch of
        'I': if Last='V' then Result := Prev + 'IX' else Result := Result + 'IV';
        'X': if Last='L' then Result := Prev + 'XC' else Result := Result + 'XL';
        'C': if Last='D' then Result := Prev + 'CM' else Result := Result + 'CD';
      end;
      N := N - max*4;
    end else begin
      N := N - max;
      Result := Result + mch;
    end;
  end;
end;

var
  N,Tests:Longint;
  UserRoman : String;
begin
  fillChar(C,sizeOf(C),0);
  C['I'] := 1;  // X, C, M, V, L, D
  C['X'] := 10;
  C['C'] := 100;
  C['M'] := 1000;
  C['V'] := 5;
  C['L'] := 50;
  C['D'] := 500;
  {}
  Tests := inf.readLongint;
  for Test := 1 to Tests do begin
    N := inf.readLongint; // Читаем число N
    assert( (1<=N) and (N<=MaxN) ); // Проверяем на соответствие ограничениям
    UserRoman := trim(ouf.readString); // Читаем ответ участника
    if N <> toDec(UserRoman) then begin // Переводим в десятичную СЧ и сравниваем ответ
      assert( toDec(toRoman(N))=N );
      Quit(_WA,Format(' (Строка %d) N = %d  User = %s = %d  Jury = %s',
        [Test,N,UserRoman,toDec(UserRoman),toRoman(N)]));
    end;
  end;
  Quit(_OK,'OK');
end.
