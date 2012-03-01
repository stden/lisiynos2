{ Решение задачи "Домино" }
{$APPTYPE CONSOLE}
{$R+}

const
  maxM = 100;

var
  domino: array [0 .. maxM, 0 .. maxM] of Boolean; { Есть ли костяшка? }
  power: array [0 .. maxM] of integer; { Степень вершины }
  comp: array [0 .. maxM] of integer; { Компонента связности вершины }
  numodd: array [1 .. maxM + 1] of integer;
  { Количество нечётных вершин в компоненте связности }
  N, M: integer;
  curcomp: integer;

procedure DFS(what: integer);
var
  i: integer;
begin
  comp[what] := curcomp;
  for i := 0 to M do
    if domino[what, i] and (comp[i] = 0) then
      DFS(i);
end;

var
  i, j: integer;
  a, b: integer;
  result: integer;

begin
  { Ввод исходных данных }
  Reset(Input, 'domino.in');
  Read(M); { Максимальное количество точек }
  assert((0 <= M) and (M <= 100));
  for i := 0 to M do
    for j := 0 to M do
      domino[i, j] := true;

  Read(N); { Количество исключённых }
  for i := 1 to N do begin
    readln(a, b);
    domino[a, b] := false;
    domino[b, a] := false;
  end;

  { Считаем степени вершин }
  for i := 0 to M do
    power[i] := 0;
  for i := 0 to M do
    for j := i to M do
      if domino[i, j] then begin
        inc(power[i]);
        inc(power[j]);
      end;

  { Раскрашиваем граф на компоненты связности }
  for i := 0 to M do
    { Исключаем изолированные вершины }
    if power[i] = 0 then
      comp[i] := maxint
    else if comp[i] = 0 then begin
      inc(curcomp);
      DFS(i);
    end;

  { Считаем количество нечётных вершин (по компонентам связности) }
  for i := 0 to M do
    if odd(power[i]) then
      inc(numodd[comp[i]]);

  { Суммируем результат }
  for i := 1 to curcomp do
    if numodd[i] = 0 then
      { Если нечётных вершин нет - обходим компоненту связности за 1 раз }
      result := result + 1
    else { Иначе - за количество пар нечётных вершин }
      result := result + numodd[i] div 2;

  { Выводим ответ }
  Rewrite(Output, 'domino.out');
  Writeln(result);
end.
