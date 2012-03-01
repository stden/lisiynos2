{ Задача "Тангенс" }
{$apptype console}

function gradrad( grad : double ):double;
begin
  gradrad := grad*Pi / 180.0;
end;

var 
  rad,grad : double;
  test,tests : integer;
begin
  assign(input,'tang.in'); reset(input);
  assign(output,'tang.out'); rewrite(output);
  read(tests);
  for test:=1 to tests do begin
    read(grad);
    rad := grad*Pi / 180.0;
    writeln( (sin(rad)/cos(rad)):0:3);
  end;
end.