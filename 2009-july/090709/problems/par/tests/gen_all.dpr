program gen_all;

{ Генерация тестов для задачи "Параллельность" }
{$APPTYPE CONSOLE}
uses
  SysUtils;

const maxAngle = 10000;
  MaxX = 10000;

{ Имя файла теста по номеру теста }
function FileName( test : integer ):string;
begin
  Result := IntToStr(test);
  if Length(Result)<2 then
    Result := '0'+Result;
end;

var test,N,i : integer;
  inf,outf : TextFile;
begin
  RandSeed := 123321;
  for test:=2 to 10 do begin
    { Открываем файл теста и ответа }
    Assign(inf,FileName(test)); rewrite(inf);
  //  Assign(outf,FileName(test)+'.a'); rewrite(outf);
    { Размерность пространства }
    N := test*test;
//    writeln(inf,N);
    for i:=1 to N do begin
      { Генерируем 2 случайных прямых }
      writeln(inf,Random(MaxX),' ',Random(MaxX),' ',Random(MaxX));
      writeln(inf,Random(MaxX),' ',Random(MaxX),' ',Random(MaxX));
//      writeln(outf,Solve(A):0:3);
    end;
    writeln(inf,'0 0 0');
    { Закрываем файлы }
    close(inf); // close(outf);
  end;
end.