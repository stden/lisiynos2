{ Ленинградская областная олимпиада 2004-2005. Районный тур }
{ Задача D. Римская система счисления }
{ Решение: Степулёнок Денис - Denis@nic.spb.ru }
{ Язык: Delphi 6.0/7.0 }
{ Техническая задача (на аккуратную реализацию) }
{$APPTYPE CONSOLE}

Uses SysUtils;

const 
  FileName = 'roman';
  MaxN = 3000;

var
  C : array ['A'..'Z'] of Longint;
const
  Sym : set of char = ['I','X','C','M','V','L','D'];

function toDec( S:String ):Integer;
var i:Integer;
begin
  { Проверка римского числа на соответвие ограничениям }
  assert( Length(S) > 0  );
  for i:=1 to Length(S) do assert( S[i] in Sym, S[i] );
  for i:=1 to Length(S)-3 do
    if ((S[i]=S[i+1]) and (S[i+1]=S[i+2])) then
      assert( S[i+2] <> S[i+3] );
  for i:=1 to Length(S)-1 do
    if S[i] in ['V','L','D'] then
      assert( S[i]<>S[i+1] );
  { Перевод }
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
  N,Tests,Test:Longint;
begin
  fillChar(C,sizeOf(C),0);
  C['I'] := 1;  // X, C, M, V, L, D
  C['X'] := 10;
  C['C'] := 100;
  C['M'] := 1000;
  C['V'] := 5;
  C['L'] := 50;
  C['D'] := 500;
  { Открываем входные/выходные файлы }
  assign(input,FileName+'.in'); reset(input);
  assign(output,FileName+'.out'); rewrite(output);
  {}
  Read( Tests );
  for Test := 1 to Tests do begin
    Read( N );
    assert( (1<=N) and (N<=MaxN) ); // Проверяем на соответствие ограничениям
    assert( toDec(toRoman(N)) = N ); // Проверяем правильность ответа
    writeln( toRoman(N) );
  end;
end.
