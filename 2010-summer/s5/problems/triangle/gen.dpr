{$APPTYPE CONSOLE}
{ Генератор тестов для длинного сложения }

uses SysUtils;

type
  Point = record
    x,y : extended;
  end;
  Triangle = record
    P1,P2,P3 : Point;
  end;

{ Имя входного файла для заданного номера теста }
function InputFileName( TestNo : Integer ):string;
begin
  Str(TestNo,Result);
  { Дополняем лидирующими нулями }
  while Length(Result) < 2 do
    Result := '0' + Result;
end;

{ Имя выходного файла для заданного номера теста }
function AnswerFileName( TestNo : Integer ):string;
begin
  Str(TestNo,Result);
  { Дополняем лидирующими нулями }
  while Length(Result) < 2 do
    Result := '0' + Result;
  Result := Result + '.a';
end;

function R( L,H : Integer ):Integer;
begin
  assert( L <= H );
  R := Random(H-L+1) + L;
end;

function GenPoint : Point;
begin
  Result.x := Random(60)/10;
  Result.y := Random(60)/10;
end;

{ Ориентированная площадь }
function Area( p,p1,p2 : Point ) : Extended;
begin
  Area := (p2.x - p1.x) * (p.y - p1.y) - (p.x - p1.x) * (p2.y - p1.y);
end;

function in_triangle( T : Triangle; P : Point ):Boolean;
var A1,A2,A3 : extended;
begin
  A1 := Area(p, T.p1, T.p2);
  A2 := Area(p, T.p2, T.p3);
  A3 := Area(p, T.p3, T.p1);
  in_triangle := ((A1 >= 0) and (A2 >= 0) and (A3 >= 0)) or
                 ((A1 <= 0) and (A2 <= 0) and (A3 <= 0));
end;

var
  Test,SubTests,SubTest,Len,i : Integer;
  NeedAnswer : Boolean; { Требуемый ответ }
  T : Triangle;
  P : Point;
  AnsFile : TextFile;
begin
  T.P1.x := 0;
  T.P1.y := 0;
  T.P2.x := 2;
  T.P2.y := 0;
  T.P3.x := 0;
  T.P3.y := 1;

  assert( Area( T.P1, T.P2, T.P3) = 2 );
  assert( Area( T.P1, T.P3, T.P2) = -2 );
  RandSeed := 778845;
  for Test := 2 to 20 do begin
    rewrite(Output,InputFileName(Test));
    rewrite(AnsFile,AnswerFileName(Test));
    { Количества тестов в тесте }
    SubTests := Test * Test + 5;
    { Записываем количество тестов в тесте }
    writeln(SubTests);
    for i := 1 to SubTests do begin
      NeedAnswer := Random(2) = 0;
      T.P1 := GenPoint;
      T.P2 := GenPoint;
      T.P3 := GenPoint;
      repeat
        P := GenPoint;
      until in_triangle(T,P) = NeedAnswer;
      {  }
      Write(T.P1.x:0:1,' ',T.P1.y:0:1,' ');
      Write(T.P2.x:0:1,' ',T.P2.y:0:1,' ');
      Writeln(T.P3.x:0:1,' ',T.P3.y:0:1);
      Writeln(P.x:0:1,' ',P.y:0:1);
      if in_triangle(T,P) then
        Writeln(AnsFile,'YES')
      else
        Writeln(AnsFile,'NO');
    end;
    CloseFile(Output);
    CloseFile(AnsFile);
  end;
end.
