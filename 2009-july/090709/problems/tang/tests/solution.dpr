{ Задача "Тангенс" }
{$apptype console}

function solve( grad : extended ):extended;
var rad : extended;
begin
  rad := grad*Pi / 180.0; { Переводим в радианы }
  solve := sin(rad)/cos(rad); { Возвращаем ответ }
end;

var 
  grad : double;
  test,tests : integer;
begin
  assign(input,'tang.in'); reset(input);
  assign(output,'tang.out'); rewrite(output);
  read(tests);
  for test:=1 to tests do begin
    read(grad);
    assert(grad >= 0);
    assert(grad <= 10000);
    writeln(solve(grad):0:3);
  end;
end.