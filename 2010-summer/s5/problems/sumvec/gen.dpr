{$APPTYPE CONSOLE}
{ Генератор тестов для задачи: Сумма векторов }

uses SysUtils;

{ Имя входного файла для заданного номера теста }
function InputFileName( TestNo : Integer ):string;
begin
  Str(TestNo,Result);
  { Дополняем лидирующими нулями }
  while Length(Result) < 2 do
    Result := '0' + Result;
end;

function R( L,H : Integer ):Integer;
begin
  assert( L <= H );
  R := Random(H-L+1) + L;
end;

var Test,Len,i : Integer;
begin
  RandSeed := 76967;
  for Test := 1 to 50 do begin
    rewrite(Output,InputFileName(Test));
    writeln(Random(Test*Test*10+10)/100:0:2,' ',Random(Test*Test*10+10)/100:0:2,' ',Random(Test*Test*10+10)/100:0:2);
    writeln(Random(Test*Test*10+10)/100:0:2,' ',Random(Test*Test*10+10)/100:0:2,' ',Random(Test*Test*10+10)/100:0:2);
    CloseFile(Output);
  end;
end.
