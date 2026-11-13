{$apptype console}

uses SysUtils;

{ Генерация тестов для задачи на простое длинное сложение }

{ Написать случайные цифры в файл }
procedure WriteRandomDigits( MaxDigits : integer );
var NumDigits : integer;
  i : integer; { переменная цикла }
begin
  NumDigits := Random(MaxDigits)+1;
  Write(Random(9)+1); { Выводим первую цифру числа }
  for i := 2 to NumDigits do
    Write(Random(10)); { Выводим случайную цифру }
  Writeln;
end;

const Digits : array ['1'..'9'] of Integer =
  (3,26,123,235,2143,4334,3246,10000,10000);
var
  Test : char;
begin
  RandSeed := 357452;
  for Test := '1' to '9' do begin
    Rewrite(output,'0'+Test);
    WriteRandomDigits(Digits[Test]);
    WriteRandomDigits(Digits[Test]);
    Close(output);
  end;
end.
